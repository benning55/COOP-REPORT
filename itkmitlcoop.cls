\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{itkmitlcoop}[2018/11/09]

\LoadClass[12pt, a4paper, oneside]{book}

\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1in]{geometry}
\RequirePackage{fontspec}
\RequirePackage{xunicode}
\RequirePackage{xltxtra}
\RequirePackage{titlesec}
\RequirePackage{eucal}
\RequirePackage{eufrak}
\RequirePackage{fancyhdr}
\RequirePackage{tabularx}
\RequirePackage{titletoc}
\RequirePackage{ifthen}
\RequirePackage{lineno}
\RequirePackage{afterpage}
\RequirePackage{subfigure}
\RequirePackage{etoolbox}
\RequirePackage{array}

% ##### new command for Roman number
\newcommand{\rNum}[1]{\lowercase\expandafter{\romannumeral #1\relax}}

% ##### Font and Typing
\XeTeXlinebreaklocale "th_TH" %สำหรับตัดคำ
\XeTeXlinebreakskip = 0pt plus 2pt
\sloppy
\linespread{1.3}
\setmainfont[Scale=1.3]{Angsana}[
Path = fonts/,
UprightFont = Angsana,
ItalicFont = *-Italic,
BoldFont = *-Bold,
BoldItalicFont = *-BoldItalic,
Extension = .ttf,
Script=Thai
]

% ##### Set Chapter and Section Style
\titleformat{\chapter}[display]
{\normalfont\Large\bfseries\centering}
{\chaptertitlename\ \thechapter}{0pt}{\LARGE}
\titlespacing*{\chapter}{0pt}{-2\baselineskip}{2em}

\titleformat{\section}
{\normalfont\large\bfseries}{\thesection}{0.5em}{}

\titleformat{\subsection}
{\normalfont\bfseries}{\thesubsection}{0.5em}{}
\titlespacing*{\subsection}{1em}{1em}{0.25em}

% ##### Re-define word
\renewcommand{\bibname}{บรรณานุกรม}
\renewcommand{\contentsname}{สารบัญ}
\renewcommand{\chaptername}{บทที่}
\renewcommand{\figurename}{รูปที่}
\renewcommand{\tablename}{ตารางที่}
\renewcommand{\listfigurename}{สารบัญรูป}
\renewcommand{\listtablename}{สารบัญตาราง}

% ##### Set a pagination style to be on top right of page
\pagestyle{fancy}
\fancyhf{} 
\renewcommand{\headrulewidth}{0pt}
\lhead{}\rhead{}\chead{}
\lfoot{}\cfoot{\thepage}\rfoot{}

% ##### Override the plain style to make the first chapter page same with other pages
\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \lhead{}\rhead{\thepage}\chead{}
    \lfoot{}\cfoot{}\rfoot{}
}

% ##### Override subfigure to use Thai alpha instead of English
\def\thaialph#1{\expandafter\thalph\csname c@#1\endcsname}
\def\thalph#1{%
    \ifcase#1\or ก\or ข\or ค\or ง\or จ\or ฉ\or ช\or ซ\or
    ฌ\or ญ\or ฎ\or ฏ\or ฐ\or ฑ\or ฒ\or ณ\or ด\or ต\or ถ\or ท\or ธ\or น\or
    บ\or ป\or ผ\or ฝ\or พ\or ฟ\or ภ\or ม\or ย\or ร\or ฤ\or ล\or ฦ\or ว\or
    ศ\or ษ\or ส\or ห\or ฬ\or อ\else ฮ\else\xpg@ill@value{#1}{thalph}\fi}
\renewcommand\thesubfigure{(\thaialph{subfigure})}

% ##### TOC Overrided 
% อ้างอิงจาก http://kt-linux.blogspot.com/2011/01/latex.html
%ตั้งค่าความลึกของหน้าสารบัญใหม่เป็น 1 (คือลงลึกแค่ชั้นเดียว) และตั้งค่าคำสั่ง \tableofcontents ใหม่
\setcounter{tocdepth}{1}
\renewcommand\tableofcontents{
    \begin{center}
        {\LARGE \textbf{สารบัญ} }
    \end{center} \vskip1em
    \begin{flushright}
        \textbf{หน้า}
    \end{flushright}
    % Hold current page value
    % for TOC heading
    \newcounter{tocitem}
    \setcounter{tocitem}{0}
    \modulolinenumbers[50]
    \linenumbers[1]
    \@starttoc{toc}
    \setcounter{tocitem}{0}
    \clearpage
    \cleardoublepage
}

%สร้างคำสั่งใหม่สำหรับตรวจสอบว่าบรรทัดปัจจุบัน หรือ จำนวนหัวข้อที่แสดงในสารบัญเกินค่าทึ่กำหนดหรือยัง หากเกินแล้วให้ตัดขึ้นหน้าใหม่ รีเซตตัวนับ tocitem รีเซตตัวนับบรรทัดใหม่ และเขียนหัวของหน้าสารบัญใหม่ (เช่น สารบัญ (ต่อ) ในกรณีนี้)
\newcommand{\tocheadcont}[3]{
    \ifthenelse{#1>30 \OR #2>30}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{tocitem}{0}
        \begin{center}
            {\LARGE \textbf{#3 (ต่อ)} }
        \end{center}  \vskip1em
        \begin{flushright}
            \textbf{หน้า}
        \end{flushright}
    }{}
}

% tocitem format for chapter
\titlecontents{chapter}[0mm]
{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{\contentsname}}
{\chaptername\hspace{1ex}\thecontentslabel\hspace{2mm}}
{}{\hfill \contentspage}

% tocitem format for section
\titlecontents{section}[0mm]
{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{\contentsname}}
{\hspace{6ex}\thecontentslabel\hspace{2mm}}{\hspace{6ex}\thecontentslabel\hspace{2mm}}
{\hfill \contentspage}

% ##### LOT Overrided 
\newcommand{\lotheadcont}[3]{
    \ifthenelse{#1>29 \OR #2>29}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{lotitem}{1}
        \begin{center}
            {\LARGE \textbf{#3 (ต่อ)} }
        \end{center}  \vskip1em
        \begin{flushright}
            \textbf{หน้า}
        \end{flushright}
    }{}
}

\renewcommand\listoftables{%
    \begin{center}
	{\LARGE \textbf{\listtablename} }
	\end{center} \vskip1em
	\begin{center}
		\textbf{ตารางที่} 
		\null \hfill
		\textbf{หน้า} \par
	\end{center}
    \resetlinenumber[1]
    \newcounter{lotitem}
    \@starttoc{lot}%
    \clearpage
    \cleardoublepage
}

\titlecontents{table}[0mm]{\stepcounter{lotitem}\lotheadcont{\thelinenumber}
{\thelotitem}{\listtablename}}{\contentspush{\thecontentslabel\hspace{2mm}}}{}
{\hfill \contentspage}

% ##### LOF Overrided 
\newcommand{\lofheadcont}[3]{
    \ifthenelse{#1>30 \OR #2>30}{
        %Should be a newpage here.
        \pagebreak[4]
        \resetlinenumber[1]
        \setcounter{lofitem}{1}
        \begin{center}
            {\LARGE \textbf{#3 (ต่อ)} }
        \end{center} \vskip1em
        \begin{center}
        	\textbf{รูปที่} 
        	\null \hfill
        	\textbf{หน้า} \par
        \end{center}
    }{}
}

\renewcommand\listoffigures{%
    \begin{center}
        {\LARGE \textbf{\listfigurename} }
    \end{center} \vskip1em
    \begin{flushright}
        \textbf{รูปที่} 
		\null \hfill
        \textbf{หน้า}
    \end{flushright}
    \resetlinenumber[1]
    \newcounter{lofitem}
    \@starttoc{lof}
    \pagewiselinenumbers
    \clearpage
    \cleardoublepage
}

% Indent the next line of the entry by the width of the label with \contentspush
\titlecontents{figure}[0mm]{\stepcounter{lofitem}\lofheadcont{\thelinenumber}
{\thelofitem}{\listfigurename}}{\contentspush{\thecontentslabel\hspace{4mm}}}{}
{\hfill\contentspage}

%  Newcommand each required page
\newcommand{\makecover}{
    % ปกนอก
    \begin{center}
        \Large{\textbf{รายงานการปฏิบัติงานสหกิจศึกษา}} \\
        \Large{\textbf{เรื่อง\\ \ThesisTiTle}} \\
        \Large{\textbf{\MakeUppercase{\ThesisTiTleEng}}} \\ \vfill
        \Large{\textbf{ปฎิบัติงาน ณ}} \\
        \Large{\textbf{\Company}} \vfill
        \Large{\textbf{โดย}} \\
        \Large{\textbf{\AuName}}  \\
        \Large{\textbf{รหัสประจำตัว \SId}} \null \vfill
        \large{\textbf{รายงานนี้เป็นส่วนหนึ่งของการศึกษารายวิชาสหกิจศึกษา \\
                สาขาวิชา\Department \  คณะเทคโนโลยีสารสนเทศ \\
                ภาคเรียนที่~\Sem \  ปีการศึกษา~\AcaY\\ 
                สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง }}
    \end{center}
}

\newcommand{\makeinnercover}{
    % ปกใน
    \newpage
    \begin{center}
        \Large{\textbf{รายงานการปฏิบัติงานสหกิจศึกษา}} \\
        \Large{\textbf{\ThesisTiTle}} \\
		\Large{\textbf{\MakeUppercase{\ThesisTiTleEng}}}\vfill
        \Large{\textbf{โดย}} \\
        \Large{\textbf{\AuName}}  \\
        \Large{\textbf{รหัสประจำตัว \SId}} \vfill
        \Large{\textbf{อาจารย์ที่ปรึกษา}} \\
        \Large{\textbf{\Advisor}} \null \vfill
        \large{\textbf{ปฏิบัติงาน ณ \Company \\
                \Address \\ 
                Web site : \Website}}
    \end{center}
}

\newcommand{\makeinnercovereng}{
    % ปกอังกฤษ
    \newpage
    \thispagestyle{empty}
    \begin{center}
        \LARGE{\textbf{\ThesisTiTleEng}} \vskip7cm
        \Large{\textbf{\AuNameENG}}  \null \vfill
        \large{\textbf{A REPORT SUBMITTED IN PARTIAL FULFILLMENT OF \\
                THE REQUIREMENT FOR COOPERATING EDUCATION PROGRAM \\
                THE DEGREE OF BACHELOR OF SCIENCE PROGRAM IN \\
                INFORMATION TECHNOLOGY \\
                FACULTY OF INFORMATION TECNOLOGY \\
                KING MONGKUT’S INSTITUTE OF TECHNOLOGY LADKRABANG \\
                \Sem / \AcaYAD}}
    \end{center}
}

\newcommand{\makecopyright}{
	
    \newpage
    \thispagestyle{empty}
    \null\vfill
    \begin{large}
        \noindent\textbf{COPYRIGHT \AcaYAD \\
            FACULTY OF INFORMATION TECHNOLOGY \\
            KING MONGKUT’S INSTITUTE OF ECHNOLOGY LADKRABANG}
    \end{large}
}

\newcommand{\makeletter}{
    %-- หนังสือส่งรายงานการปฏิบัติงานสหกิจศึกษา -------------------------------------------
    \newpage
    \begin{flushright}
        วันที่ \SubD
    \end{flushright}
    
    \noindent เรื่อง ขอส่งรายงานการปฏิบัติงานสหกิจศึกษา \\
    เรียน \Advisor \vskip0.1cm

    \hskip0.2cm ที่ปรึกษาสหกิจศึกษาในสาขาเทคโนโลยีสารสนเทศ (\Branch)\vskip1cm
    
    ตามที่ข้าพเจ้า เสฎฐวุฒิ ไม้สนธิ์ นักศึกษาสาขาวิชา เทคโนโลยีสารสนเทศ คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง ได้ปฏิบัติงานสหกิจศึกษาระหว่างวันที่ \StartDWork \ ถึงวันที่ \EndDWork \ ในตำแหน่ง \Position \ ณ สถานประกอบการชื่อ \Company \ และได้รับมอบหมายจากพนักงานที่ปรึกษาให้ศึกษาและจัดทำรายงาน เรื่อง \ThesisTiTle
    
    บัดนี้ การปฏิบัติงานสหกิจศึกษาได้สิ้นสุดลงแล้ว จึงใคร่ขอส่งรายงานการปฏิบัติงาน สหกิจศึกษาดังกล่าวมาพร้อมนี้ จำนวน 1 เล่ม เพื่อขอรับคำปรึกษาต่อไป 
    
    จึงเรียนมาเพื่อโปรดพิจารณา 
    
    \vskip1.5cm
    \begin{flushright}    
        \begin{tabular}{c}
            ขอแสดงความนับถือ \\ \\
            .............................................................. \\
            (นาย \AuName ) 
        \end{tabular}
    \end{flushright}
}

\newcommand{\makeack}[1]{
    %-- ACKNOWLEDGEMENTS Page -------------------------------------------
    \newpage
    \chapter*{กิตติกรรมประกาศ}
    \thispagestyle{empty}
    
    ตามที่ข้าพเจ้า นาย \AuName \ ได้มาปฏิบัติงานสหกิจศึกษา ณ \Company \ ตั้งแต่วันที่ \StartDWork \ ถึงวันที่ \EndDWork \ ทำให้ข้าพเจ้าได้รับความรู้และประสบการณ์ต่าง ๆ ที่มีคุณค่ามากมาย สำหรับรายงานสหกิจศึกษาฉบับนี้สำเร็จลงได้ด้วยดี จากความช่วยเหลือและความร่วมมือสนับสนุนของหลายฝ่าย ดังนี้ 
    
    #1
    
    นอกจากนี้ยังขอขอบคุณ \Advisor \ อาจารย์ที่ปรึกษา และ ยังมีบุคคลท่านอื่น ๆ อีกที่ไม่ได้กล่าวไว้ ณ ที่นี้ ซึ่งให้ความกรุณาแนะนำในจัดทำรายงานสหกิจศึกษาฉบับนี้ ข้าพเจ้าจึงใคร่ขอขอบพระคุณทุกท่านที่ได้มีส่วนร่วมในการให้ข้อมูลและให้ความเข้าใจเกี่ยวกับชีวิตของการปฏิบัติงาน รวมถึงเป็นที่ปรึกษาในการจัดทำรายงานฉบับนี้จนเสร็จสมบูรณ์ 
    
    \vskip1.5cm
    \begin{flushright}    
        \begin{tabular}{c}
            \AuName \\
            ผู้จัดทำรายงาน \\
            วันที่ \SubD
        \end{tabular}
    \end{flushright}
}

\newcommand{\makeapproveletter}{
    %-X- หน้าอนุมัติรายงาน -X------------------------------------------
    % Do NOT EDIT this page
    \newpage
    \begin{table}[h]
        \begin{tabularx}{\linewidth}{lX}
            \textbf{ชื่อรายงานการปฏิบัติงานสหกิจศึกษา} & \ThesisTiTle \\
            \textbf{ผู้รายงาน} & \AuName \\
            \textbf{คณะ} & เทคโนโลยีสารสนเทศ \\
            \textbf{สาขาวิชา} & \Department
        \end{tabularx}
    \end{table} \vfill
    
    
    \begin{center}
        ...................................................................... \\
        (\Advisor ) \\
        อาจารย์ที่ปรึกษาสหกิจศึกษา \vfill
        
        ...................................................................... \\
        (\Exami) \\
        พนักงานที่ปรึกษา \null \vfill
        
        คณะเทคโนโลยีสารสนเทศ สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง	\\
        อนุมัติให้นับรายงานการปฏิบัติงานสหกิจศึกษาฉบับนี้ เป็นส่วนหนึ่งของการศึกษา \\
        ตามหลักสูตรวิทยาศาสตรบัณฑิต สาขาวิชา\Department
        
    \end{center}
}

\newcommand{\makeabstract}[1]{
    %-- Abstract Page ------------------------------------------
    \newpage
    \addcontentsline{toc}{chapter}{บทคัดย่อ}
    
    \begin{table}[h]
        \begin{tabularx}{\linewidth}{lX}
			\textbf{ชื่อรายงาน} & \ThesisTiTle \\
			\textbf{ชื่อนักศึกษา} & \AuName \\
			\textbf{รหัสนักศึกษา} & \SId \\
			\textbf{สาขาวิชา} & \Department \\
			\textbf{อาจารย์ที่ปรึกษา} & \Advisor \\
			\textbf{ปีการศึกษา} & \AcaY
        \end{tabularx}
    \end{table}
    
    
    \vskip1cm
    \begin{center}
        \textbf{\Large บทคัดย่อ}
    \end{center}
    
    #1
}

\newcommand{\makeabstracteng}[1]{
	%-- Abstract Page ------------------------------------------
	\newpage
	\addcontentsline{toc}{chapter}{บทคัดย่อ ภาษาอังกฤษ}
	
	\begin{table}[h]
		\begin{tabularx}{\linewidth}{lX}
			\textbf{Project Title} & \ThesisTiTleEng \\
			\textbf{Student} & \AuNameEng \\
			\textbf{Student ID} & \SId \\
			\textbf{Program} & \DepartmentEng \\
			\textbf{Advisor} & \AdvisorEng \\
			\textbf{Year} & \AcaY
		\end{tabularx}
	\end{table}
	
	
	\vskip1cm
	\begin{center}
		\textbf{\Large ABSTRACT}
	\end{center}
	
	#1
}



\newcommand\startappendix{
	\appendix
	\renewcommand*{\appendixname}{}
	\renewcommand{\thechapter}{\thaialph{chapter}}
	
	\titleformat{\chapter}[display]{\normalfont\Large\bfseries\centering}{}{0pt}{\LARGE}
	\titlespacing*{\chapter}{0pt}{-3.2\baselineskip}{2em}
	
	
	\titlecontents{chapter}[0mm]
	{\stepcounter{tocitem}\tocheadcont{\thelinenumber}{\thetocitem}{สารบัญ}}
	{ภาคผนวก\hspace{1ex}\thecontentslabel\hspace{2mm}}
	{}{\hfill \contentspage}
}