% ===================================================================
% science-profile.cls
% A personal LaTeX class for styling manifestos and profiles.
% Author: Liam
% Version: 1.0
% Date: 2025/08/12
% ===================================================================

% 1. BOILERPLATE: Identify this file as a class and handle options
% -------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{science-profile}[2025/08/12 Science Profile Class]

% Pass any unknown options (like 'fontsize=12pt') to the base class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax


% 2. FOUNDATION: Load the base class and required packages
% -------------------------------------------------------------------
% We build on KOMA-Script's article class for its power and flexibility
\LoadClass{scrartcl}

\RequirePackage{fontspec}      % For using system fonts
\RequirePackage{xcolor}        % For advanced color definitions
\RequirePackage{setspace}      % For controlling line spacing
\RequirePackage[skins]{tcolorbox} % The best package for styled boxes
\RequirePackage{titling}       % For easy customization of the main title
\RequirePackage{hyperref}      % For custom link colors
\RequirePackage{lua-ul}                 % 💡 REPLACEMENT for `polyglossia`
\RequirePackage{luatexja-fontspec}      % 💡 REPLACEMENT for `xeCJK`


% 3. PAGE LAYOUT: Define the overall document geometry and spacing
% -------------------------------------------------------------------
% Set KOMA-Script options for a clean, modern page layout
\KOMAoptions{
  DIV=14,             % Calculate a generous text area for readability
  fontsize=12pt       % Set the base font size for normal text
}

\AtBeginDocument{%
  \areaset{6in}{\textheight} % width,height of text area
}

\setstretch{1.15}      % Set a comfortable line spacing for all text
\setlength{\parskip}{10pt} % Spacing after normal text paragraphs

% 4. TYPOGRAPHY: Define the fonts and colors
% -------------------------------------------------------------------

\AtBeginDocument{
  \directlua{
  -- Table of fallback fonts for specific Unicode ranges
  local fallback_fonts = {
    { range = {0x2600, 0x26FF}, font = "DejaVu Sans Mono" }, -- Misc symbols (☉, ☀, etc.)
    { range = {0x2200, 0x22FF}, font = "Latin Modern Math" }, -- Math symbols
    { range = {0x1F300, 0x1F5FF}, font = "Noto Color Emoji" } -- Emoji
  }

  -- Cache loaded fallback fonts keyed by font name
  local loaded_fallbacks = {}

  -- Find fallback font for a given codepoint
  local function get_fallback_font(cp)
    for _, fb in ipairs(fallback_fonts) do
      if cp >= fb.range[1] and cp <= fb.range[2] then
        if not loaded_fallbacks[fb.font] then
          loaded_fallbacks[fb.font] = font.read_open_type(fb.font) or font.read_tfm(fb.font)
        end
        return loaded_fallbacks[fb.font]
      end
    end
    return nil
  end

-- Override glyph lookup with a metatable
callback.register("define_font", function(name, size)
  local id = font.read_open_type(name, size) or font.read_tfm(name, size)
  if not id then return nil end
  local orig_chars = id.characters
  id.characters = setmetatable({}, {
    __index = function(_, cp)
      local g = orig_chars[cp]
      if g then return g end
      local fb_font = get_fallback_font(cp)
      return fb_font and fb_font.characters[cp] or nil
    end
  })
  return id
end)
}
}

\newfontface\bodyfontface{Courier Prime}[Renderer=HarfBuzz]
\newfontface\fallbackfontface{DejaVu Sans Mono}
\newfontface\oswaldlight{Oswald}[Weight=Light]
\newfontface\oswaldbold{Oswald}[Weight=Bold]
\newfontface\japanesefontface{IwaSouNPro-Md}

% Apply main font at begin document
\AtBeginDocument{%
  \bodyfontface
}

% Define a personal color palette based on Google Docs colors and hex codes
\definecolor{DarkYellow1}{RGB}{241, 194, 50}
\definecolor{DarkRed1}{RGB}{204, 0, 0}
\definecolor{DarkRed2}{RGB}{153, 0, 0}
\definecolor{H1TextColor}{HTML}{c66d12}


% 5. MAIN TITLE STYLING: Define the look of \maketitle
% -------------------------------------------------------------------
% Remove the default vertical drop of the title to standardize top margin
\setlength{\droptitle}{0pt}

% We use the `titling` package to easily insert a tcolorbox
% around the main document title.
\renewcommand{\maketitle}{%
  \begingroup
    \newlength{\titlewidth}
    \settowidth{\titlewidth}{\oswaldlight\fontsize{26pt}{31pt}\selectfont\color{DarkRed1}\thetitle}%

    % Check if title width exceeds 0.5\textwidth
    \ifdim\titlewidth>0.5\textwidth
      \def\tcboxwidth{0.75\textwidth}%
    \else
      \def\tcboxwidth{0.5\textwidth}%
    \fi

    \begin{tcolorbox}[
      width=\tcboxwidth,
      colback=DarkYellow1,
      colframe=DarkYellow1,
      sharp corners,
      halign=left,
      frame hidden,
      after skip=20pt
    ]
      \oswaldlight\fontsize{26pt}{31pt}\selectfont\color{DarkRed1}\thetitle
    \end{tcolorbox}
  \endgroup
}

% 6. HEADING FONT SIZES & COLORS: Define the font styles for KOMA elements
% -------------------------------------------------------------------
% We use KOMA's native command to set the font, size, AND color.
% This will be inherited when the commands are called inside the tcolorboxes.
\setkomafont{section}{\oswaldlight\color{H1TextColor}\fontsize{22pt}{26pt}\selectfont}
\setkomafont{subsection}{\oswaldlight\color{DarkYellow1}\fontsize{19pt}{23pt}\selectfont}
\setkomafont{subsubsection}{\oswaldlight\color{white}\fontsize{13pt}{16pt}\selectfont}


% 7. HEADING STYLING: Define the look of sections, subsections, etc.
% -------------------------------------------------------------------
% Create a reusable base style for all our heading boxes using tcolorbox
\tcbset{
  headingstyle/.style={
    enhanced,
    width=0.5\textwidth,
    frame hidden,        % reliably hides the frame and border
    boxsep=0pt,
    sharp corners,
    left=16pt, right=8pt, top=8pt, bottom=7pt
  }
}

% Redefine \section (h1)
\let\oldsection\section
\let\oldtableofcontents\tableofcontents
% "Table of Contents" -> "werrej"
\renewcommand{\tableofcontents}{%
  \begin{tcolorbox}[headingstyle, colback=white!0, left=0pt]
    \oldsection*{werrej}
  \end{tcolorbox}%
  % Print the TOC without its own title
  \begingroup
    \renewcommand{\section}[2]{} % temporarily disable \section inside TOC
    \oldtableofcontents
  \endgroup
}%

% Redefine \section (h1) to handle both starred and unstarred
\RenewDocumentCommand{\section}{s m}{%
  \IfBooleanTF{#1}{%
    % starred: leave as-is
    \oldsection*{#2}%
  }{%
    \par % ensure we are in vertical mode
    % unstarred: wrap in tcolorbox
    \begin{tcolorbox}[
      headingstyle,
      colback=DarkYellow1,
      before skip=20pt,
      after skip=20pt
    ]
      \oldsection{#2}%
    \end{tcolorbox}%
  }%
}

% Redefine \subsection (h2)
\let\oldsubsection\subsection
\renewcommand{\subsection}[1]{%
  \begin{tcolorbox}[
    headingstyle,
    colback=DarkRed1,
    before skip=15pt, % Spacing before h2
    after skip=15pt   % Spacing after h2
  ]
  \oldsubsection{#1}
  \end{tcolorbox}%
}

% Redefine \subsubsection (h3)
\let\oldsubsubsection\subsubsection
\renewcommand{\subsubsection}[1]{%
  \begin{tcolorbox}[
    headingstyle,
    colback=black,
    before skip=15pt, % Spacing before h3
    after skip=15pt   % Spacing after h3
  ]
  \oldsubsubsection{#1}
  \end{tcolorbox}%
}

% 8. HYPERLINK STYLING
% -------------------------------------------------------------------
% Set up colors for hyperlinks using the hyperref package
\AtBeginDocument{%
  \hypersetup{
    colorlinks=true,
    urlcolor=DarkRed2,
    linkcolor=DarkRed2,
    citecolor=DarkRed2
  }%
}

% 8. USEFUL COMMANDS
% -------------------------------------------------------------------
%

% date with hanging indent after
\newlength{\firstwordlen}
\def\dateparagraph#1 #2\par{%
  \settowidth{\firstwordlen}{#1\ }%
  \hangindent=\firstwordlen
  \hangafter=1
  \textbf{#1} #2\par
}

% --- End of liam-profile.cls ---
