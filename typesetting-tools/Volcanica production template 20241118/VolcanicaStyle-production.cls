%------------------------------------------------------------
%  Identification 
%------------------------------------------------------------	
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{volcanica}[25-07-2024 Volcanica paper]

\ProcessOptions\relax
\LoadClass[draft,10.5pt,twoside,a4paper,twocolumn]{article}

%------------------------------------------------------------
%  Additional packages, not defined elsewhere 
%------------------------------------------------------------	
\RequirePackage[%
               separate-uncertainty=true,
               multi-part-units=single,
               range-phrase = --,
               range-units=single
]{siunitx}
\DeclareSIUnit\year{yr} 						% New units can be defined here
\RequirePackage{lipsum}
\RequirePackage{chemformula}
\RequirePackage{enumitem}
\RequirePackage{changes}


%------------------------------------------------------------
%  Define some ifs, for use in author template
%------------------------------------------------------------	
\newif\ifdraft
\newif\ifnumlines

%------------------------------------------------------------
%  Font declarations
%------------------------------------------------------------	
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc} 					% Font encoding
\RequirePackage[light]{antpolt} 					% Antykwa Półtawskiegosrif font
\RequirePackage[varg]{newtxmath} 				% Math font
\DeclareMathSizes{10}{10}{7.5}{6}				% Set relative sizes
\RequirePackage[condensed]{roboto} 			% Sans serif font
\renewcommand{\seriesdefault}{m} 				% fix the bad declaration made by roboto
\RequirePackage[scaled=0.8]{GoMono} 			% Monospaced font

%------------------------------------------------------------
%  New characters
%------------------------------------------------------------	
\DeclareRobustCommand{\okina}{%
  \raisebox{\dimexpr\fontcharht\font`f-\height}{%
    \scalebox{0.8}{`}%
  }%
}

%------------------------------------------------------------
%  Page set-up
%------------------------------------------------------------	
\RequirePackage[tmargin=1in,
                            bmargin=1in,
                            lmargin=0.7in,
                            rmargin=0.7in]{geometry} 

%------------------------------------------------------------
%  Title and section set-up
%------------------------------------------------------------	
\RequirePackage{titlesec}
\titleformat*{\section}{\large \sc \sffamily}
\titlespacing*{\section}{0pt}{2ex}{1ex}
\titleformat*{\subsection}{\sffamily}
\titlespacing*{\subsection}{0pt}{2ex}{1ex}
\titleformat*{\subsubsection}{\it\sffamily}
\titlespacing*{\subsubsection}{0pt}{1.5ex}{.5ex}
\renewcommand{\thesubsubsection}{\emph{\thesubsection.\arabic{subsubsection}}}

\title{\vspace{4ex}\LARGE \sffamily\Title\vspace{0ex}}
\newcommand{\Year}{\the\year}

\makeatletter
\renewcommand{\maketitle}{\bgroup\setlength{\parindent}{0pt}
\begin{center}
  \@title
\end{center}
\begin{flushleft}
  \@author
\end{flushleft}\egroup
}
\makeatother

%------------------------------------------------------------
%  Abstract set-up
%------------------------------------------------------------	
% more commands defined below
\RequirePackage{abstract}
\renewcommand{\abstractnamefont}{\flushleft \normalfont \large \sc \sffamily}
\setlength{\absleftindent}{0mm}
\setlength{\absrightindent}{0mm}

%------------------------------------------------------------
%  Author set-up
%------------------------------------------------------------	
\RequirePackage[noblocks]{authblk}
\renewcommand*{\Affilfont}{\sffamily  \small}
\renewcommand*{\Authfont}{\sffamily \large}
\RequirePackage[stable,perpage,flushmargin]{footmisc}
\renewcommand{\thefootnote}{\fnsymbol{footnote}}
\setlength{\affilsep}{.5ex}
\renewcommand\Authand{ and }
\renewcommand\Authands{, and }
\date{}

\RequirePackage{tikz}
\usetikzlibrary{svg.path}
\RequirePackage{scalerel}

\definecolor{orcidlogocol}{HTML}{A6CE39}
\tikzset{
  orcidlogo/.pic={
    \fill[orcidlogocol] svg{M256,128c0,70.7-57.3,128-128,128C57.3,256,0,198.7,0,128C0,57.3,57.3,0,128,0C198.7,0,256,57.3,256,128z};
    \fill[white] svg{M86.3,186.2H70.9V79.1h15.4v48.4V186.2z}
                 svg{M108.9,79.1h41.6c39.6,0,57,28.3,57,53.6c0,27.5-21.5,53.6-56.8,53.6h-41.8V79.1z M124.3,172.4h24.5c34.9,0,42.9-26.5,42.9-39.7c0-21.5-13.7-39.7-43.7-39.7h-23.7V172.4z}
                 svg{M88.7,56.8c0,5.5-4.5,10.1-10.1,10.1c-5.6,0-10.1-4.6-10.1-10.1c0-5.6,4.5-10.1,10.1-10.1C84.2,46.7,88.7,51.3,88.7,56.8z};
  }
}

\newbox{\myorcidaffilbox}
\sbox{\myorcidaffilbox}{{\scalerel*{
\begin{tikzpicture}[yscale=-1,transform shape]
\pic{orcidlogo};
\end{tikzpicture}
}{|}}}

\newcommand{\orcidaffil}[1]{%
  \href{https://orcid.org/#1}{\raisebox{0.15 em}{\usebox{\myorcidaffilbox}}}}


%------------------------------------------------------------
%  Affiliations set-up
%------------------------------------------------------------	
\RequirePackage{amsmath}
\RequirePackage{xparse}
\RequirePackage{fontawesome}

\ExplSyntaxOn
\NewDocumentCommand{\lcgreek}{m}
 {
  \str_case:nn { #1 }
   {
    {1}{$\alpha$}{2}{$\beta$}{3}{$\gamma$}
    {4}{$\delta$}{5}{$\varepsilon$}{6}{$\zeta$}
    {7}{$\eta$}{8}{$\theta$}{9}{$\iota$}
    {10}{$\kappa$}{11}{$\lambda$}{12}{$\mu$}
    {13}{$\nu$}{14}{$\xi$}{15}{$o$}
    {16}{$\varpi$}{17}{$\varrho$}{18}{$\varsigma$}
    {19}{$\tau$}{20}{$\upsilon$}{21}{$\phi$}
    {22}{$\chi$}{23}{$\psi$}{24}{$\omega$}
    {\#}{\texttt{Add~affiliation}}{}{Add~affiliation}
   }
 }
\ExplSyntaxOff

\newcommand{\affiliation}[1]{\lowercase{\lcgreek{#1}}}

\newcommand{\software}[1]{\texttt{#1}}
\let\sw\software
\RequirePackage{xspace}
\newcommand\la{$\langle$} 
\newcommand\ra{$\rangle$\xspace} 

%------------------------------------------------------------
%  Hyperlink set-up
%------------------------------------------------------------	
\RequirePackage{xcolor}
\PassOptionsToPackage{table}{xcolor}
\definecolor{PUSblue}{HTML}{005FA8}
\definecolor{commentgreen}{HTML}{008000}
\definecolor{bggrey}{HTML}{D7DBDD}
\definecolor{vlight-gray}{gray}{0.95}
\definecolor{light-gray}{gray}{0.85}

\definecolor{mordantred19}{rgb}{0.68, 0.05, 0.0}
\definecolor{rufous}{rgb}{0.66, 0.11, 0.03}
\definecolor{pyroclast}{HTML}{A40000}

\RequirePackage[final]{hyperref} 
\RequirePackage{xpatch}
\hypersetup{colorlinks = true, 
			citecolor = pyroclast, 
			linkcolor=pyroclast,
			urlcolor  = pyroclast}

\urlstyle{tt}
\usepackage{url}
\usepackage{doi}
\usepackage[backend=biber,maxcitenames=2,block=space,
			useprefix=true,style=authoryear-comp,
			sorting=ynt,firstinits,uniquename=false,
			uniquelist=false,maxbibnames=99,date=year,hyperref=true,
			 sortcites=true,backref=false, abbreviate=false]{biblatex}
			 
\DeclareSourcemap{
  \maps[datatype=bibtex, overwrite]{
    \map{
      \step[fieldset=language, null]
%      \step[fieldset=issn, null]
      \step[fieldset=arxivId, null]
      \step[fieldset=archivePrefix, null]
      \step[fieldset=eprint, null]
    }
  }
}
\AtEveryBibitem{\clearfield{issn}}
\AtEveryCitekey{\clearfield{issn}}


\newcommand\blfootnote[1]{%
  \begingroup
  \renewcommand\thefootnote{}\noindent\footnote{#1}%
  \addtocounter{footnote}{-1}\vspace{-2.5\baselineskip}%
  \endgroup
}

\newcommand{\Email}[1]{\thanks{\noindent\faEnvelopeO~~\lowercase{\href{mailto:#1}}{\texttt{#1}}}}

%------------------------------------------------------------
%  Keyword set-up
%------------------------------------------------------------	
\RequirePackage{stringstrings} % \capitalize, \caselower
\newcommand{\sentencecase}[1]{\caselower[e]{#1}\capitalize{\thestring}}

\newcommand{\sep}{;~}

\makeatletter
\newcommand{\keywords}[1]{%
    {\sc\sffamily Keywords:} \sffamily{{#1}}\checknextarg}
\newcommand{\checknextarg}{\@ifnextchar\bgroup{\gobblenextarg}{.}}
%\newcommand{\gobblenextarg}[1]{\sep \sffamily{\sentencecase{#1}}\@ifnextchar\bgroup{\gobblenextarg}{.}}
\newcommand{\gobblenextarg}[1]{\sep \sffamily{\capitalize{#1}}\@ifnextchar\bgroup{\gobblenextarg}{.}}

%------------------------------------------------------------
%  Define pages
%------------------------------------------------------------	
\RequirePackage{lastpage}
\newcommand{\Pages}{\textsc{\FirstPage--\pageref*{LastPage}}}

%------------------------------------------------------------
%  Define DOI
%------------------------------------------------------------	
\def\leadingZero#1{% 
\ifnum#1<10 0\fi 
\number#1}

\newcommand{\DOInum}{\leadingZero{\Volume}.\leadingZero{\Issue}.\FirstPage\LastPage}
\newcommand{\DOI}{\url{https://doi.org/10.30909/vol.\DOInum}}
\newcommand{\supmat}[1]{\href{https://doi.org/10.30909/vol.\DOInum}{Supplementary Material {#1}}}

%------------------------------------------------------------
%  Caption set-up
%------------------------------------------------------------	
\RequirePackage[font=sf]{caption}
\captionsetup[figure]{labelfont={},name={Figure},labelsep=colon}
\captionsetup[table]{labelfont={},name={Table},labelsep=colon}
\captionsetup[listing]{labelfont={},name={Listing},labelsep=colon}

%------------------------------------------------------------
%  Header set-up
%------------------------------------------------------------	
\RequirePackage{graphicx}
\setkeys{Gin}{draft=false}  % to get illustrations to print, even in draft mode

\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE]{\sf\shortTitle}
\fancyhead[RE]{\sf{\Author} \ \Year}
\fancyhead[LO]{{\VOLCANICA}}
\fancyhead[RO]{{\sf \Volume (\Issue): ~\Pages.} \ \DOI}
\rfoot{{\sf Page \thepage}}
\lfoot{\includegraphics[width=0.75\columnwidth]{PUSbanner2}}
\fancypagestyle{firststyle}
{
   \fancyhf{}
   \fancyhead{\includegraphics[width=\textwidth]{research-article-banner-new}}
}

\RequirePackage{csquotes}
\newcommand{\defaultLanguage}{english}
\newcommand{\default}{\expandafter\selectlanguage\expandafter{\defaultLanguage}}
\RequirePackage{babel}

\addto\extrasenglish{%
  \renewcommand{\sectionautorefname}{Section}%
  \renewcommand{\subsectionautorefname}{Section}%
  \renewcommand{\subsubsectionautorefname}{Section}%
  }

%------------------------------------------------------------
%  Citations set-up
%------------------------------------------------------------	
\ExecuteBibliographyOptions{url=false}
\ExecuteBibliographyOptions{doi=true}
\newbibmacro{string+doi}[1]{% 
 \iffieldundef{doi}{#1}{\href{https://doi.org/\thefield{doi}}{#1}}}
  \DeclareFieldFormat{title}{\usebibmacro{string+doi}{\mkbibemph{#1}}}
\DeclareFieldFormat[article]{title}{\usebibmacro{string+doi}{\mkbibquote{#1}}}

%\AtBeginDocument{%
%  \apptocmd\thebibliography{\interlinepenalty=10 }{}{}%
%}

\makeatletter
   \newrobustcmd*{\parentexttrack}[1]{%
     \begingroup
     \blx@blxinit
     \blx@setsfcodes
     \blx@bibopenparen#1\blx@bibcloseparen
  \endgroup}
  \AtEveryCite{%
   \let\parentext=\parentexttrack%
   \let\bibopenparen=\bibopenbracket%
   \let\bibcloseparen=\bibclosebracket}
\makeatother

% -------------
\DeclareFieldFormat{citehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{#1}}

\DeclareFieldFormat{textcitehyperref}{%
  \DeclareFieldAlias{bibhyperref}{noformat}% Avoid nested links
  \bibhyperref{%
    #1%
    \ifbool{cbx:parens}
      {\bibcloseparen\global\boolfalse{cbx:parens}}
      {}}}

\savebibmacro{cite}
\savebibmacro{textcite}

\renewbibmacro*{cite}{%
  \printtext[citehyperref]{%
    \restorebibmacro{cite}%
    \usebibmacro{cite}}}


\xpatchbibmacro{textcite}
  {\printnames{labelname}}
  {\printtext[bibhyperref]{\printnames{labelname}}}
  {}{}



%------------------------------------------------------------
%  Issue parentheses 
%------------------------------------------------------------
% No dot before number of articles
\xpatchbibmacro{volume+number+eid}{%
  \setunit*{\adddot}%
}{%
}{}{}

% Number of articles in parentheses
\DeclareFieldFormat[article]{number}{\mkbibparens{#1}}

%------------------------------------------------------------
%  Define \Autoref 
%------------------------------------------------------------	
% allows multiple references to be passed to \autoref
\makeatletter
\newcommand\Autoref[1]{\@first@ref#1,@}
\def\@throw@dot#1.#2@{#1}% discard everything after the dot
\def\@set@refname#1{%    % set \@refname to autoefname+s using \getrefbykeydefault
    \edef\@tmp{\getrefbykeydefault{#1}{anchor}{}}%
    \xdef\@tmp{\expandafter\@throw@dot\@tmp.@}%
    \ltx@IfUndefined{\@tmp autorefnameplural}%
         {\def\@refname{\@nameuse{\@tmp autorefname}s}}%
         {\def\@refname{\@nameuse{\@tmp autorefnameplural}}}%
}
\def\@first@ref#1,#2{%
  \ifx#2@\autoref{#1}\let\@nextref\@gobble% only one ref, revert to normal \autoref
  \else%
    \@set@refname{#1}%  set \@refname to autoref name
    \@refname~\ref{#1}% add autorefname and first reference
    \let\@nextref\@next@ref% push processing to \@next@ref
  \fi%
  \@nextref#2%
}
\def\@next@ref#1,#2{%
   \ifx#2@ and~\ref{#1}\let\@nextref\@gobble% at end: print and+\ref and stop
   \else, \ref{#1}% print  ,+\ref and continue
   \fi%
   \@nextref#2%
}
\makeatother

%------------------------------------------------------------
%  Define \panelref 
%------------------------------------------------------------	
\newcommand{\panelref}[2]{\hyperref[#1]{\autoref*{#1}#2}}
\newcommand{\panref}[2]{\hyperref[#1]{\ref*{#1}#2}}
%------------------------------------------------------------

%------------------------------------------------------------
%  Define a macro \fullref
%------------------------------------------------------------	
% Allows referencing section number and name

\newcommand*{\fullref}[1]{\hyperref[{#1}]{\ref*{#1} \nameref*{#1}}}


%------------------------------------------------------------
%  Balancing columns
%------------------------------------------------------------	
\RequirePackage{balance}
\RequirePackage[keeplastbox]{flushend} % [keeplastbox] avoids incorrect indenting at end of bibliography
\makeatletter
    \def\balanceissued{unbalanced}%flag to indicate if \balance has been used
    \let\oldbibitem\bibitem
    \def\bibitsem{%
        \ifnum\thepage=\lastpage@lastpage%
            \expandafter\ifx\expandafter\relax\balanceissued\relax\else%
                \balance%
                \gdef\balanceissued{\relax}\fi%
            \else\fi%
        \oldbibitem}
\makeatother

%------------------------------------------------------------
%  Define \VOLCANICA logo text
%------------------------------------------------------------	
\definecolor{maroon}{rgb}{0.5, 0.0, 0.0}
%\definecolor{maroon2}{HTML}{D60A0A}

\makeatletter
\newcommand{\VA}{\raisebox{.72 em}{\rotatebox{180}{V}}}
\newcommand{\VOLCANICA}{\protect{\sffamily {VOLC{\color{pyroclast}{\VA}}NIC{\VA}~}}}
\makeatother

\RequirePackage{hologo}
\makeatletter
\newcommand{\latex}{\protect{\sffamily \hologo{LaTeX}~}}
\makeatother

%------------------------------------------------------------
%  Some global parameters 
%------------------------------------------------------------	
% Ensures that there will not be any widow or club lines,
\widowpenalty10000
\clubpenalty10000

%------------------------------------------------------------
%  Draft set-up 
%------------------------------------------------------------	
% currently unfinished
%%% 3) Declare Options and Use Default Options
%\DeclareOption{draft}{\global\drafttrue}
%\DeclareOption{linenumbers}{\global\numlinestrue}
%\DeclareOption{final}{\setlength\overfullrule{0pt}\global\draftfalse}
%
%
%\ExecuteOptions{draft,10.5pt,twoside,a4paper,twocolumn,final}
%\ProcessOptions
%
%\ifnumlines
%\linenumbers*[1]
%\fi

%------------------------------------------------------------
%  Enabled during draft/ review stage 
%------------------------------------------------------------	
\usepackage{draftwatermark}
\SetWatermarkText{\texttt{uncorrected proof}}
\SetWatermarkScale{0.45}
\SetWatermarkColor[gray]{0.90}

%------------------------------------------------------------
%  Front matter set-up 
%------------------------------------------------------------	
\RequirePackage{eso-pic, rotating}
\newcommand{\Editors}[2]{
\AddToShipoutPictureBG*{\put(20,90){\rotatebox{90}{\scalebox{1}{{\textcolor{gray}{\sffamily Editor: {#1}~|~Typesetter: {#2}}}}}}}
}

\newcommand{\Dates}{
\AddToShipoutPictureBG*{\put(20,440){\rotatebox{90}{\scalebox{1}{{\textcolor{gray}{\sffamily Submitted: {\SubDate}~|~Accepted: {\AccDate}~|~Published: {\PubDate}}}}}}}
}

\newcommand{\InPress}[0]{
\AddToShipoutPictureBG{\put(100, 500){\scalebox{3}{{\textcolor{light-gray}{\LARGE\sffamily --Article in Press--}}}}}
\AddToShipoutPictureBG{\put(20,500){\rotatebox{90}{\scalebox{1}{{\textcolor{gray}{\sffamily --Article in Press--}}}}}}
}

\makeatletter
\def\IfEmptyTF#1{%
  \if\relax\detokenize{#1}\relax
    \expandafter\@firstoftwo
  \else
    \expandafter\@secondoftwo
  \fi}
\makeatother

\newcommand{\Abstract}[1]{\begin{abstract}{\normalsize\sffamily\noindent{#1}
%\vspace{0.5\baselineskip}
}
\end{abstract}}
%
%\RequirePackage{opensans}
%\newenvironment{myfont}{\fontfamily{opensans-LF}\selectfont}{\par}
%
%\newcommand\finline[3][]{\begin{myfont}[#1]{#2}#3\end{myfont}}%
%
% ENVIRONMENT FOR NEW FONT
%\newenvironment{myfont}[2][]{\csname#2\endcsname[#1]}{}
%
%\newcommand{\Alpine}[1][]{\fontfamily{opensans-LF}#1\selectfont}
%
%
%\renewcommand{\sfdefault}{opensans-LF}
\NewDocumentCommand{\Abstracts}{mo}{%%
  {\vspace{.25\baselineskip}\default\Abstract{#1}\vspace{-.25\baselineskip}}{}
\IfEmptyTF{#2}{}{{\vspace{-.5\baselineskip}\expandafter\selectlanguage\expandafter{\secondLanguage}{\Abstract{#2}}\vspace{-.5\baselineskip}}}
\vspace{-.25\baselineskip}
}
%\NewDocumentCommand{\Abstracts}{mo}{%%
%  {\vspace{.25\baselineskip}\default\Abstract{#1}\vspace{-.25\baselineskip}}{}
%\IfEmptyTF{#2}{\vspace{-1\baselineskip}}{{\vspace{-.5\baselineskip}\expandafter\selectlanguage\expandafter{\secondLanguage}\renewcommand{\abstractname}{Ágrip}\Abstract{#2}\vspace{-.5\baselineskip}}}
%\default
%}%

\newcommand{\SuggestedCitation}{\noindent\authorlist~(\Year). ``\Title''. \emph{Volcanica} \Volume (\Issue), pp. \Pages. {\textsc{DOI:}~}\DOI.}

%\RequirePackage{etoolbox}
%    \makeatletter
%        \patchcmd{\maketitle}
%            {\def\@makefnmark}
%            {\def\@makefnmark{}\def\useless@macro}
%            {}{}
%    \makeatother
%\usepackage{xpatch}
%\makeatletter
%% 1. remove all redefinitions about footnotes done by \maketitle
%%    and add \titletrue
%\renewcommand\maketitle{\par
%  \begingroup
%    \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
%    \titletrue
%    \if@twocolumn
%      \ifnum \col@number=\@ne
%        \@maketitle
%      \else
%        \twocolumn[\@maketitle]%
%      \fi
%    \else
%      \newpage
%      \global\@topnum\z@   % Prevents figures from going at top of page.
%      \@maketitle
%    \fi
%    \thispagestyle{plain}\@thanks
%  \endgroup
%  \setcounter{footnote}{0}%
%  \global\let\thanks\relax
%  \global\let\maketitle\relax
%  \global\let\@maketitle\relax
%  \global\let\@thanks\@empty
%  \global\let\@author\@empty
%  \global\let\@date\@empty
%  \global\let\@title\@empty
%  \global\let\title\relax
%  \global\let\author\relax
%  \global\let\date\relax
%  \global\let\and\relax
%}
% 2. define a conditional
\newif\iftitle
% 3. redefine \@makefnmark to print nothing when \titletrue
\xpretocmd{\@makefnmark}{\iftitle\else}{}{}
\xapptocmd{\@makefnmark}{\fi}{}{}
% 4. ensure \@makefntext has \titlefalse
%    that's justified by the fact that \@makefnmark
%    in \@makefntext is set in a box
\xpretocmd{\@makefntext}{\titlefalse}{}{}

\makeatother

\DeclareDocumentCommand{\FrontMatter}{mom}{
\twocolumn[
  \begin{@twocolumnfalse}
    \maketitle \vspace*{\baselineskip}
    \thispagestyle{firststyle}
\vspace*{\baselineskip}
\setcounter{page}{\FirstPage}
\selectlanguage{english}
\vspace{-3\baselineskip}
{\expandafter\Abstracts{#1}[#2]}
\begin{center}{#3}\vspace{.25\baselineskip}
\end{center}
 \end{@twocolumnfalse}
] 
\saythanks
%\blfootnote{Suggested citation:~{\SuggestedCitation}}
}

%------------------------------------------------------------
%  End matter set-up 
%------------------------------------------------------------	
\newcommand{\EndMatter}{
\section*{Copyright notice}
\CopyrightNotice\vspace{-1.5mm}%\vspace{5 pt}
 \balance
\begin{refcontext}[sorting=nyt]
\printbibliography
\end{refcontext}
\clearpage
}

\newcommand{\Contributions}[1]{
\hypertarget{author-contributions}{%
\section*{Author Contributions}\label{author-contributions}}
{#1}
}

\newcommand{\Acknowledgments}[1]{
\hypertarget{acknowledgements}{%
\vspace{-2mm}\section*{Acknowledgements}\label{acknowledgements}}
{#1}
}

\newcommand{\DataAvailability}[1]{
\hypertarget{data-availability}{%
\section*{Data Availability}\label{data-availability}}
{#1}
}

\newcommand{\CopyrightNotice}{{\noindent\textcopyright~The Author(s)~\Year. This article is distributed under the terms of the \href{http://creativecommons.org/licenses/by/4.0/}{\texttt{Creative Commons Attribution 4.0 International License}}, which permits unrestricted use, distribution, and reproduction in any medium, provided you give appropriate credit to the original author(s) and the source, provide a link to the Creative Commons license, and indicate if changes were made.}}\vspace{-2mm}


%------------------------------------------------------------
%  "How to cite" set up 
%------------------------------------------------------------	
% currently unused
%
%\makeatletter
%\newcommand*{\authorlist}{%
%    \begingroup
%    \let\footnote\@gobble% ignore \footnote
%    \let\textsuperscript\@gobble% ignore protected \textsuperscript
%    \expandafter\let\csname textsuperscript \endcsname\@gobble
%     \let\thanks\@gobble% ignore thanks
%     \let\orcidaffil\@gobble% ignore orcid
%    \let\Authfont\relax% do not use a special font
%    \def\Authand{~and }% separate list of authors by ,
%    \AB@authlist% show them all
%    \fi
%    \endgroup
%}
%%\def\@firstof@authlist#1\footnote#2\@nil{#1}% skip all from the first footnote
%\makeatother
%%
%\newcommand{\HowtoCite}{
%\section*{How to Cite}
%\noindent\authorlist~(\Year). ``\Title''. \emph{Volcanica} \Volume (\Issue), pp. \Pages. {\textsc{DOI:}~}\DOI.
%}
%%%%%%%
% Table set up

%------------------------------------------------------------
%  Table set-up 
%------------------------------------------------------------	
% might need to add additional packages for sideways environments, etc.
\RequirePackage{threeparttable}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{colortbl}
\setdeletedmarkup{\sout{\textcolor{red}{#1}}}
\newcommand*\rot{\rotatebox{90}}

%------------------------------------------------------------
%  Greek set-up 
%------------------------------------------------------------	
% Map upright greek characters from Fourier

\DeclareFontEncoding{FML}{}{}
\DeclareFontSubstitution{FML}{futm}{m}{it}
\DeclareSymbolFont{fourieritalic}{FML}{futmii}{m}{it}
\let\altalpha\alpha\DeclareMathSymbol{\alpha}{\mathord}{fourieritalic}{11}
\let\altbeta\beta\DeclareMathSymbol{\beta}{\mathord}{fourieritalic}{12}
\let\altgamma\gamma\DeclareMathSymbol{\gamma}{\mathord}{fourieritalic}{13}
\let\altdelta\delta\DeclareMathSymbol{\delta}{\mathord}{fourieritalic}{14}
\let\altepsilon\epsilon\DeclareMathSymbol{\epsilon}{\mathord}{fourieritalic}{15}
\let\altzeta\zeta\DeclareMathSymbol{\zeta}{\mathord}{fourieritalic}{16}
\let\alteta\eta\DeclareMathSymbol{\eta}{\mathord}{fourieritalic}{17}
\let\alttheta\theta\DeclareMathSymbol{\theta}{\mathord}{fourieritalic}{18}
\let\altiota\iota\DeclareMathSymbol{\iota}{\mathord}{fourieritalic}{19}
\let\altkappa\kappa\DeclareMathSymbol{\kappa}{\mathord}{fourieritalic}{20}
\let\altlambda\lambda\DeclareMathSymbol{\lambda}{\mathord}{fourieritalic}{21}
\let\altmu\mu\DeclareMathSymbol{\mu}{\mathord}{fourieritalic}{22}
\let\altnu\nu\DeclareMathSymbol{\nu}{\mathord}{fourieritalic}{23}
\let\altxi\xi\DeclareMathSymbol{\xi}{\mathord}{fourieritalic}{24}
\let\alpi\pi\DeclareMathSymbol{\pi}{\mathord}{fourieritalic}{25}
\let\altrho\rho\DeclareMathSymbol{\rho}{\mathord}{fourieritalic}{26}
\let\altsigma\sigma\DeclareMathSymbol{\sigma}{\mathord}{fourieritalic}{27}
\let\alttau\tau\DeclareMathSymbol{\tau}{\mathord}{fourieritalic}{28}
\let\altupsilon\upsilon\DeclareMathSymbol{\upsilon}{\mathord}{fourieritalic}{29}
\let\altphi\phi\DeclareMathSymbol{\phi}{\mathord}{fourieritalic}{30}
\let\altchi\chi\DeclareMathSymbol{\chi}{\mathord}{fourieritalic}{31}
\let\altpsi\psi\DeclareMathSymbol{\psi}{\mathord}{fourieritalic}{32}
\let\altomega\omega\DeclareMathSymbol{\omega}{\mathord}{fourieritalic}{33}
\let\altvarepsilon\varepsilon\DeclareMathSymbol{\varepsilon}{\mathord}{fourieritalic}{34}
\let\altvartheta\vartheta\DeclareMathSymbol{\vartheta}{\mathord}{fourieritalic}{35}
\let\altvarpi\varpi\DeclareMathSymbol{\varpi}{\mathord}{fourieritalic}{36}
\let\altvarrho\varrho\DeclareMathSymbol{\varrho}{\mathord}{fourieritalic}{37}
\let\altvarsigma\varsigma\DeclareMathSymbol{\varsigma}{\mathord}{fourieritalic}{38}
\let\altvarphi\varphi\DeclareMathSymbol{\varphi}{\mathord}{fourieritalic}{39}
\newcommand{\omicron}{$\textrm{o}$}