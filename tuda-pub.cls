%- Identification -%

% Version
\def\fileversion{1.00}
\def\filedate{2021/08/17}

% Sets the LaTeX version for the package to work.
\NeedsTeXFormat{LaTeX2e}

%- Preconfig -%

%-- LateX 3 Syntax --%
\RequirePackage{expl3}

%-- Color --%
\RequirePackage[table]{xcolor}

% Identification of the class
\ProvidesExplClass{tuda-pub}
	{\filedate}
	{\fileversion}
	{(TUDa-CI) - Exercise Template}

%- Customization -%

% Bibliography included
\bool_set_false:N \l__ptxcd_bib_source_bool

% Pseudocode with ending
\bool_set_false:N \l__ptxcd_pseudocode_noend_bool

%- Preconfiguration -%

% imakeidx must be loaded before hyperref or else  the hyperlinks for the index are not working.
\AddToHook{package/before/hyperref}{\RequirePackage{imakeidx}}
% \AddToHook{package/before/hyperref}{\RequirePackage[xindy]{imakeidx}}

%- Preconfiguration -%
\LoadClass[
    chapterentrydots=true,
	class=report,
	color=3b,
	colorback=false,
	bibliography=totoc,
	marginpar=false,
	ngerman,
	type=intern,
	listof=totoc,
]{tudapub}

% Document color
\newcommand{\documentcolor}{\g_ptxcd_color_accent_tl}

%- Packages -%

%-- Biblopgraphy --%
% Bib source enabled
\bool_if:NT \l__ptxcd_bib_source_bool {
	\RequirePackage[
    	backend=biber,
    	maxbibnames=99,
    	sorting=ynt,
    	style=numeric
    	]{biblatex}
}

%-- Box --%
\RequirePackage{tcolorbox}

%-- Caption --%
% Centering caption
\RequirePackage[justification=centering]{caption}

%-- Code --%
\RequirePackage{code-listings}

%-- Graphics--%
% Relative graphic path
\RequirePackage{graphicx}
\RequirePackage{tikz}
\RequirePackage{memory-block}

%-- Import --%
% Import document content from another direcotry or different document.
\RequirePackage{import}
% Creating standalone documents to add them as sub document to the main document.
\RequirePackage{standalone}

%-- KOMA-Script --%
% Using Koma's float algorithm
\RequirePackage{scrhack}

%-- Language --%
\RequirePackage[english, main=ngerman]{babel}
% Quotes
\RequirePackage[babel]{csquotes}

%-- List --%
\RequirePackage{enumitem}

%-- Math --%
\RequirePackage{amsmath, amssymb}
% Lightning symbol
\RequirePackage{stmaryrd}
% Bold
\RequirePackage{bm}

%-- Pseudocode --%
% No end option is enabled
\bool_if:NT \l__ptxcd_pseudocode_noend_bool {
	\PassOptionsToPackage{noend}{algpseudocode}
}
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}

%-- Table --%
% beautiful tables
\RequirePackage{booktabs}
% Coloring
\RequirePackage{colortbl}
% Combine rows
\RequirePackage{multirow}

%- Patch -%

% Patching  library in expl3 removing white spaces
\patchcmd
	{\pgfutil@InputIfFileExists}
	{\input #1}
	{%
		\@pushfilename
		\xdef\@currname{#1}%
		\input #1 %
		\@popfilename
	}
	{}{}

%- Bibliography -%

% Bib source enabled
\bool_if:NT \l__ptxcd_bib_source_bool {
    % Default bibliography source
    \addbibresource{bibliography.bib}

    % Url line break
    \setcounter{biburllcpenalty}{7000}
    \setcounter{biburlucpenalty}{8000}

    %-- Language --%
    \providecaptionname{ngerman, german}{\bibliographynamelanguage}{Literaturverzeichnis}
    \providecaptionname{english, american, british}{\bibliographynamelanguage}{Bibliography}
}

%- Box -%

%-- Note boxes --%
% Custom skins
\tcbuselibrary{skins}

% Dictionary of default tuda colors
\prop_new:N \l__ptxcd_box_color_tuda_prop
\prop_put:Nnn \l__ptxcd_box_color_tuda_prop {tuda-gray} {TUDa-0c}
\prop_put:Nnn \l__ptxcd_box_color_tuda_prop {tuda-blue} {TUDa-2c}
\prop_put:Nnn \l__ptxcd_box_color_tuda_prop {tuda-dgreen} {TUDa-3b}
\prop_put:Nnn \l__ptxcd_box_color_tuda_prop {tuda-lgreen} {TUDa-4c}
\prop_put:Nnn \l__ptxcd_box_color_tuda_prop {tuda-orange} {TUDa-8b}
\prop_put:Nnn \l__ptxcd_box_color_tuda_prop {tuda-red} {TUDa-9b}

% Expand prop item
\cs_generate_variant:Nn \prop_item:Nn { Ne }

% Title of the box
\tl_new:N \l__ptxcd_box_title_tl
% Color of the box
\str_new:N \l__ptxcd_box_color_str

% Box options
% Do not make setting globally visible, only for one environment
\keys_define:nn {ptxcd/notebox}{
	title .code:n=\tl_set:Nn \l__ptxcd_box_title_tl {#1},
	title .default:n=,
	title .initial:n=,
	break .bool_set:N =\l__ptxcd_box_title_break_bool,
	break .default:n=true,
	break .initial:n=false,
	color .code:n=\str_set:Nx \l__ptxcd_box_color_str {#1},
	color .default:n=\g_ptxcd_color_accent_tl,
	color .initial:n=\g_ptxcd_color_accent_tl
}

% Note box environment
\NewDocumentEnvironment{note}{o}
{
	%  Process options
	\IfNoValueF{#1}{\keys_set:nn {ptxcd/notebox}{#1}}
	% Retrieve color
	\str_set:Nx \l__ptxcd_box_color_apply_str {\str_use:N \l__ptxcd_box_color_str}
	% Check if the color is a predefined tuda color and retrieve color value
	\prop_if_in:NVT \l__ptxcd_box_color_tuda_prop \l__ptxcd_box_color_apply_str
	{
		% Retrieve color valur from prop
		\str_set:Nx \l__ptxcd_box_color_apply_str {
			\prop_item:Ne \l__ptxcd_box_color_tuda_prop { \str_use:N \l__ptxcd_box_color_apply_str}
		}
	}

	% Side note box
	\begin{tcolorbox}[
		arc=3pt, % Rounded borders
		boxrule=0pt,
		colback=\l__ptxcd_box_color_apply_str!5,
		enhanced, % Enable customization
		frame\space hidden,
		left=5pt, % Left side margin
		overlay={
			\begin{tcbclipinterior}
				\fill[\l__ptxcd_box_color_apply_str] (frame.south\space west) rectangle ([xshift=4pt]frame.north\space west);
			\end{tcbclipinterior}
		}
		]
		% Print title if it is not empty
		 \tl_if_empty:NF \l__ptxcd_box_title_tl {
		 	\textbf{\tl_use:N \l__ptxcd_box_title_tl}
		 	% Break line if option is on
		 	\bool_if:NT \l__ptxcd_box_title_break_bool{
		 		\\
		 	}
	 	}
}
{
	\end{tcolorbox}
}

%- Hyperref -%

\hypersetup{
    colorlinks=true,
    linkcolor=black,
    urlcolor=TUDa-2c,
}

%- Index -%

%-- Graphics --%
\usetikzlibrary{shadows.blur, shapes}

%-- Language --%
% Index name
\providecaptionname{ngerman, german}{\indexnamelanguage}{Stichwortverzeichnis}
\providecaptionname{english, american, british}{\indexnamelanguage}{Index}

% Numbers
\providecaptionname{ngerman, german}{\indexothersname}{Sonstiges}
\providecaptionname{english, american, british}{\indexothersname}{Miscellaneous}


%- KOMA-Script -%

% Unbold title
\addtokomafont{author}{\mdseries}

%- Math -%

\DeclareMathOperator{\argmin}{argmin}
\DeclareMathOperator{\argmax}{argmax}
\newcommand{\Var}{\mathrm{Var}}

%- Paragraph -%

% Indent
\setlength{\parindent}{0pt}
% Line break header and no indent
\cs_set_eq:NN \__ptxcd_paragraph:n \paragraph
\renewcommand{\paragraph}[1]{\__ptxcd_paragraph:n {#1}\hfill}

% Linke break
\newcommand{\br}{\vskip .5em}

%- Table of content -%

% Clear toc to next age
\newcommand{\cleartoc}{\addtocontents{toc}{\protect\clearpage}}

%- Title -%

%-- Author --%
\providecaptionname{ngerman, german}{\autorname}{
	\int_compare:nNnTF {\seq_count:N \l__ptxcd_author_seq} > {1}
	{Autoren}
	{Autor}
}
\providecaptionname{english, american, british}{\autorname}{
	\int_compare:nNnTF {\seq_count:N \l__ptxcd_author_seq} > {1}
	{Author}
	{Authors}
}

% Author sep for last author
\providecaptionname{ngerman, german}{\authorsep}{und}
\providecaptionname{english, american, british}{\authorsep}{and}

\seq_new:N \l__ptxcd_author_seq

% Push students to a sequence
\newcommand{\authors}[1]{
	% Push author name to the right
	\seq_put_right:Nn \l__ptxcd_author_seq {#1}

	% Prepare author convention
	\tl_set:Nx \c__ptxcd_namesr_tl {\seq_item:Nn \l__ptxcd_author_seq {1}}
	% Comma separated authors
	\int_step_inline:nn {\seq_count:N \l__ptxcd_author_seq - 2}  {
		\tl_set:Nx \c__ptxcd_namesr_tl {
			\tl_use:N \c__ptxcd_namesr_tl, \space
			\seq_item:Nn \l__ptxcd_author_seq {\int_eval:n {##1 + 1}}
		}
	}
	% Last author will be separated with "and"
	\int_compare:nNnTF {\seq_count:N \l__ptxcd_author_seq} > {1}
	% If more than two author exists, add an "and, else do nothing
	{
		\tl_set:Nx \c__ptxcd_namesr_tl {
			\tl_use:N \c__ptxcd_namesr_tl\space
			\authorsep\space
			\seq_item:Nn \l__ptxcd_author_seq {\seq_count:N \l__ptxcd_author_seq}
		}
	}{}
	% Set authors
	\author{\tl_use:N \c__ptxcd_namesr_tl}
}

%-- Version --%
\newcommand{\@version}{\today}
\newcommand{\version}[1]{\renewcommand{\@version}{#1}}
\providecaptionname{ngerman, german}{\versionname}{Version}
\providecaptionname{english, american, british}{\versionname}{Version}

%-- Department --%
\tl_new:N \l__ptxcd_department_tl
\newcommand{\department}[1]{\tl_gset:Nx \l__ptxcd_department_tl {#1}}
\providecaptionname{ngerman, german}{\departmentname}{Fachbereich}
\providecaptionname{english, american, british}{\departmentname}{Department}

%-- Semester --%
\tl_new:N \l__ptxcd_semester_str
\newcommand{\semester}[1]{\tl_gset:Nx \l__ptxcd_semester_tl {#1}}
\providecaptionname{ngerman, german}{\semestername}{Semester}
\providecaptionname{english, american, british}{\semestername}{Semester}

%-- Title style --%
\newcommand{\@titleformat}{
    \begin{minipage}[t]{.475\linewidth}
        % Author, department
        \xdef\@author {\@author}
		\ifx\@author\@empty
		\else
		    \textbf{\autorname :}\space\usekomafont{author}\@author
		\fi
        \tl_if_empty:NF \l__ptxcd_semester_tl
        {
            \\
            \usekomafont{author}\textbf{\departmentname :}\space\tl_use:N \l__ptxcd_department_tl
        }

    \end{minipage}
    \hfill
    \begin{minipage}[t]{.475\linewidth}
        % Version, semester, sheet number
        \begin{flushright}
            \usekomafont{author}\textbf{\versionname :}\space\@version\raggedleft
            \tl_if_empty:NF \l__ptxcd_semester_tl
            {
                \\
                \tl_use:N \l__ptxcd_semester_tl\raggedleft
            }
        \end{flushright}
    \end{minipage}
}
\newcommand{\titleformat}[1]{\renewcommand{\@titleformat}{#1}}

%-- Title format --%
\renewcommand{\@maketitle}{%
	\global\@topnum=\z@
	\setparsizes{\z@}{\z@}{\z@\@plus 1fil}\par@updaterelative
	\vspace*{-\dim_eval:n {
			\headheight
			+\headsep
			+\topskip
			-\box_ht:N\ptxcd_headrule_box
			-\box_dp:N \ptxcd_headrule_box
	}}
	\par
	\nointerlineskip
	\begingroup
	\usekomafont{disposition}
	\hsize=\g_ptxcd_headwidth_dim
	\setlength{\fboxsep}{\z@}
	\bool_if:NT \g_ptxcd_colorback_bool {\colorbox{accentcolor}}{\parbox[t]{\g_ptxcd_headwidth_dim}{
			\rule{\z@}{.5\c_ptxcd_logoheight_dim}\par\nointerlineskip
			\raisebox{-\height}{%
				\begin{minipage}[t]{\dimexpr\linewidth-2.2\c_ptxcd_logoheight_dim-1ex}
					\bool_if:NT \g_ptxcd_colorback_bool  {\begin{addmargin}{.5\c_ptxcd_largerule_dim}}
						\raggedright
						\bool_if:NT \g_ptxcd_colorback_bool {\color{textonaccentcolor}}
						\tl_if_empty:NF \@titlehead {\usekomafont{titlehead}{\@titlehead\par}}
						\leavevmode
						{\Huge\usekomafont{title}{
								\Huge
								\@title \par
						}}%
						\vskip .5em
						{\Large\usekomafont{subtitle}{
								% Adjust hspace to align subtitle under title
								\hspace*{.05em}
								\Large
								\@subtitle \par
						}}%
						\vskip 1em
						\bool_if:NTF \g_ptxcd_colorback_bool {\end{addmargin}} {\par}
					\vspace{\dim_eval:n {\c_ptxcd_largerule_dim+\c_ptxcd_rulesep_dim}}
				\end{minipage}
			}
			\hfill
			\raisebox{-\height}{
				\ptxcd_setup_title_box:
				\makebox[2.2\c_ptxcd_logoheight_dim][l]{
					\box_use:N \g_ptxcd_title_info_box
				}
			}
			\dim_compare:nNnTF {\box_ht:N \g_ptxcd_title_info_box + \box_ht:N \g_ptxcd_title_info_box} > {1.1\c_ptxcd_logoheight_dim}
			{\vspace{\c_ptxcd_largerule_dim}}
			{\vspace{.5\c_ptxcd_logoheight_dim}}

			\par
	}}
	\par
	\nointerlineskip
	\rule{\g_ptxcd_headwidth_dim}{\g_ptxcd_titlerule_dim}
	\begin{addmargin}{.5\c_ptxcd_largerule_dim}
		\Large
		\@titleformat
		\vspace{\c_ptxcd_rulesep_dim}
	\end{addmargin}
	\tl_if_empty:NF \@thanks {
		\par\nointerlineskip
		\rule{\g_ptxcd_headwidth_dim}{\g_ptxcd_titlerule_dim}
		\expandafter\fontsize\ptxcd_titlethanks_fontsize:\selectfont
		\begin{addmargin}{.5\c_ptxcd_largerule_dim}
			\let\footnotetext\ptxcd_title@footnote
			\@thanks
			\vspace{\c_ptxcd_rulesep_dim}
		\end{addmargin}
		\par
		\let\@thanks\@empty
	}
	\par\nointerlineskip
	\rule{\g_ptxcd_headwidth_dim}{\g_ptxcd_titlerule_dim}
	\par
	\endgroup
	\vskip .5\c_ptxcd_logoheight_dim
}%

%- Additional configurations -%
