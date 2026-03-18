# LuaSnip Snippets

A collection of LuaSnip snippets for various programming languages in Neovim.

## Table of Contents

- [C](#1-c)
- [C++](#2-c)
- [Dart](#3-dart)
- [Python](#4-python)
  - [General Python](#41-general-python)
  - [Web Scraping](#42-web-scraping)
  - [Pwntools](#43-pwn-snippets-pwntools)
  - [NumPy](#44-scientific-computing-numpy)
  - [Pandas](#45-pandas)
  - [Matplotlib / Seaborn](#46-matplotlib--seaborn)
  - [Z3 / SMT Solver](#47-z3--smt-solver)
  - [CLI / Automation](#48-cli--automation)
  - [Testing](#49-testing)
  - [Web Frameworks](#410-web-frameworks)
  - [Concurrency / Async](#411-concurrency--async)
  - [File I/O / Serialization](#412-file-io--serialization)
  - [Type Hints](#413-type-hints)
  - [Logging / Debugging](#414-logging--debugging)
  - [DateTime](#415-datetime)
  - [Collections / Utilities](#416-collections--utilities)
  - [Math / Statistics](#417-math--statistics)
  - [Path / Glob](#418-path--glob)
  - [functools](#419-functools)
  - [dataclasses / attrs](#420-dataclasses--attrs)
  - [Pyshark / Network Analysis](#421-pyshark--network-analysis)
- [HTML](#5-html)
- [CSS](#6-css)
- [JavaScript](#7-javascript)

---

## 1. C

| Trigger | Description |
|---------|-------------|
| `main` | C main entry point |

---

## 2. C++

| Trigger | Description |
|---------|-------------|
| `main` | C++ main entry point |
| `oi-cf` | Codeforces template |

---

## 3. Dart

| Trigger | Description |
|---------|-------------|
| `mainapp` | Creates main function and basic MyApp (StatelessWidget) |
| `stateless` | Creates a StatelessWidget template |
| `stateful` | Creates a StatefulWidget template |
| `scaffold` | Creates a basic Scaffold structure |
| `print` | Shortcut for print statement |
| `con` | Generates const constructor |
| `sizedbox` | Generates SizedBox with height/width |
| `column` | Generates Column with children |
| `row` | Generates Row with children |
| `listview` | Generates ListView with children |
| `mediaquery` | Accesses MediaQuery.of(context).size.xxx |
| `initstate` | Generates initState method |
| `dispose` | Generates dispose method |
| `getx` | GetX Controller binding Get.put() |

---

## 4. Python

### 4.1 General Python

| Trigger | Description |
|---------|-------------|
| `main` | Python main entry point |
| `defmain` | Python main entry with function |
| `def` | Function definition |
| `cls` | Class definition |
| `for` | Iterate over a collection |
| `pdb` | Pdb breakpoint |
| `openrb` | Open a file with rb flag |
| `openwb` | Open a file with wb flag |
| `openr` | Open a file with r flag |
| `openw` | Open a file with w flag |
| `try` | Try except block |
| `tryef` | Try except finally block |
| `lambda` | Lambda function |
| `decorator` | Decorator function |
| `dataclass` | Dataclass definition |
| `enum` | Enum class definition |
| `listcomp` | List comprehension |
| `dictcomp` | Dictionary comprehension |
| `with` | Context manager |
| `yield` | Generator function |
| `property` | Property decorator |
| `staticmethod` | Static method |
| `classmethod` | Class method |
| `abc` | Abstract base class |
| `match` | Match case statement (Python 3.10+) |

### 4.2 Web Scraping

| Trigger | Description |
|---------|-------------|
| `ireqbs` | Import requests and BeautifulSoup |
| `rget` | requests.get template |
| `bsoup` | BeautifulSoup initialization |
| `wcsv` | Write data to CSV file |

### 4.3 Pwn Snippets (Pwntools)

| Trigger | Description |
|---------|-------------|
| `pwninit` | Pwntools basic template |
| `pu` | Pack/Unpack functions |
| `gdbatt` | GDB attach |
| `sl` | io.sendline() |
| `sla` | io.sendlineafter() |
| `s` | io.send() |
| `sa` | io.sendafter() |

### 4.4 Scientific Computing (NumPy)

| Trigger | Description |
|---------|-------------|
| `inp` | Import NumPy |
| `nparray` | NumPy array creation |
| `nparray2d` | NumPy 2D array |
| `nparange` | NumPy arange |
| `nplinspace` | NumPy linspace |
| `npzeros` | NumPy zeros array |
| `npones` | NumPy ones array |
| `npeye` | NumPy identity matrix |
| `nprand` | NumPy random array |
| `nprandint` | NumPy random integer |
| `npreshape` | NumPy reshape |
| `nptranspose` | NumPy transpose |
| `npdot` | NumPy dot product |
| `npmatmul` | NumPy matrix multiplication |
| `npconcat` | NumPy concatenate |
| `npsum` | NumPy sum |
| `npmaxmin` | NumPy max/min |
| `npargmax` | NumPy argmax/argmin |
| `npwhere` | NumPy where |
| `npunique` | NumPy unique |
| `npsave` | NumPy save/load |

### 4.5 Pandas

| Trigger | Description |
|---------|-------------|
| `ipd` | Import Pandas |
| `pddf` | Pandas DataFrame creation |
| `pdreadcsv` | Pandas read CSV |
| `pdreadxlsx` | Pandas read Excel |
| `pdreadjson` | Pandas read JSON |
| `pdreadsql` | Pandas read SQL |
| `pddftocsv` | DataFrame to CSV |
| `pdhead` | DataFrame head |
| `pdinfo` | DataFrame info |
| `pddescribe` | DataFrame describe |
| `pdgroupby` | DataFrame groupby |
| `pdmerge` | DataFrame merge |
| `pdconcat` | DataFrame concat |
| `pdapply` | DataFrame apply |
| `pdfillna` | DataFrame fillna |
| `pddropna` | DataFrame dropna |
| `pdloc` | DataFrame loc |
| `pdiloc` | DataFrame iloc |
| `pddrop` | DataFrame drop columns |
| `pdrename` | DataFrame rename columns |

### 4.6 Matplotlib / Seaborn

| Trigger | Description |
|---------|-------------|
| `implt` | Import Matplotlib |
| `isns` | Import Seaborn |
| `pltfig` | Matplotlib figure |
| `pltsave` | Save matplotlib figure |
| `pltplot` | Matplotlib plot |
| `pltscatter` | Matplotlib scatter plot |
| `plthist` | Matplotlib histogram |
| `pltbar` | Matplotlib bar chart |
| `pltimshow` | Matplotlib imshow |
| `pltheatmap` | Seaborn heatmap |
| `snsbox` | Seaborn boxplot |
| `snsviolin` | Seaborn violinplot |
| `snspair` | Seaborn pairplot |

### 4.7 Z3 / SMT Solver

| Trigger | Description |
|---------|-------------|
| `iz3` | Import Z3 |
| `z3solver` | Z3 basic solver |
| `z3opt` | Z3 optimization |
| `z3int` | Z3 Int variable |
| `z3real` | Z3 Real variable |
| `z3bool` | Z3 Bool variable |
| `z3bv` | Z3 BitVector |
| `z3array` | Z3 Array |
| `z3list` | Z3 List |
| `z3sat` | Z3 sat check |
| `z3unsat` | Z3 unsat check |
| `z3model` | Z3 get model |
| `z3forall` | Z3 ForAll quantifier |
| `z3exists` | Z3 Exists quantifier |
| `z3simplify` | Z3 simplify |
| `z3substitute` | Z3 substitute |
| `z3distinct` | Z3 Distinct |
| `z3sum` | Z3 Sum |
| `z3product` | Z3 Product |

### 4.8 CLI / Automation

| Trigger | Description |
|---------|-------------|
| `iargparse` | Import argparse |
| `argp` | Argparse template |
| `argpbool` | Argparse boolean flag |
| `iclick` | Import click |
| `clickcmd` | Click command template |
| `icli` | Import typer |
| `typerapp` | Typer app template |
| `isubprocess` | Import subprocess |
| `subpopen` | Subprocess run command |
| `subpcall` | Subprocess call |
| `subpcheck` | Subprocess check_output |
| `ishutil` | Import shutil |
| `shutilcopy` | Shutil copy file |
| `shutilmove` | Shutil move file |
| `shutilrmtree` | Shutil remove directory |
| `imkdir` | Create directory |
| `igetpass` | Import getpass |
| `getpass` | Get password input |

### 4.9 Testing

| Trigger | Description |
|---------|-------------|
| `ipytest` | Import pytest |
| `pytestfn` | Pytest function |
| `pytestcls` | Pytest class |
| `pytestfix` | Pytest fixture |
| `pytestparam` | Pytest parametrize |
| `pytestmark` | Pytest mark |
| `pytest.raises` | Pytest raises |
| `pytestsetup` | Pytest setup/teardown |
| `iunittest` | Import unittest |
| `unittestcls` | Unittest class |
| `unittestmain` | Unittest main |
| `assertEqual` | assertEqual |
| `assertTrue` | assertTrue |
| `assertFalse` | assertFalse |
| `assertIsNone` | assertIsNone |
| `assertIn` | assertIn |
| `assertRaises` | assertRaises |

### 4.10 Web Frameworks

| Trigger | Description |
|---------|-------------|
| `ifastapi` | Import FastAPI |
| `fastapiapp` | FastAPI app template |
| `fastapiget` | FastAPI GET route |
| `fastapipost` | FastAPI POST route |
| `iflasks` | Import Flask |
| `flaskapp` | Flask app template |
| `flaskroute` | Flask route |
| `flaskjson` | Flask jsonify |

### 4.11 Concurrency / Async

| Trigger | Description |
|---------|-------------|
| `iasyncio` | Import asyncio |
| `asynciomain` | Asyncio main function |
| `asyncdef` | Async function |
| `asynciotask` | Asyncio create task |
| `asynciogather` | Asyncio gather |
| `asynciowait` | Asyncio wait |
| `ithreading` | Import threading |
| `thread` | Thread creation |
| `threadlock` | Thread with lock |
| `imp` | Import multiprocessing |
| `mpproc` | Multiprocessing process |
| `mppool` | Multiprocessing pool |
| `ipool` | Import concurrent.futures |
| `threadpool` | ThreadPoolExecutor |
| `processpool` | ProcessPoolExecutor |

### 4.12 File I/O / Serialization

| Trigger | Description |
|---------|-------------|
| `ijson` | Import json |
| `jsondump` | JSON dump |
| `jsonload` | JSON load |
| `ijoblib` | Import joblib |
| `joblibdump` | Joblib dump |
| `joblibload` | Joblib load |
| `ipickle` | Import pickle |
| `pickledump` | Pickle dump |
| `pickleload` | Pickle load |
| `iyaml` | Import yaml |
| `yamldump` | YAML dump |
| `yamlload` | YAML load |
| `itoml` | Import toml |
| `tomlcomp` | toml.loads / toml.dumps |

### 4.13 Type Hints

| Trigger | Description |
|---------|-------------|
| `typelist` | List type hint |
| `typedict` | Dict type hint |
| `typetuple` | Tuple type hint |
| `typeunion` | Union type hint |
| `typeopt` | Optional type hint |
| `typecall` | Callable type hint |
| `typeany` | Any type hint |
| `typecast` | cast function |
| `typefinal` | Final type hint |
| `typenamed` | NamedTuple |

### 4.14 Logging / Debugging

| Trigger | Description |
|---------|-------------|
| `ilog` | Import logging |
| `logbasic` | Logging basic config |
| `logget` | Get logger |
| `logdebug` | Logging debug |
| `loginfo` | Logging info |
| `logwarn` | Logging warning |
| `logerror` | Logging error |
| `logexc` | Logging exception |
| `itqdm` | Import tqdm |
| `tqdm` | Tqdm progress bar |
| `tqdmwr` | Tqdm wrapper |

### 4.15 DateTime

| Trigger | Description |
|---------|-------------|
| `idatetime` | Import datetime |
| `datetime.now` | Current datetime |
| `datetime.strptime` | Parse datetime string |
| `datetime.strftime` | Format datetime |
| `timedelta` | Timedelta |
| `idateutil` | Import dateutil |
| `dateutilparse` | dateutil parser |

### 4.16 Collections / Utilities

| Trigger | Description |
|---------|-------------|
| `icollections` | Import collections |
| `defaultdict` | DefaultDict |
| `counter` | Counter |
| `deque` | Deque |
| `ifunctools` | Import functools |
| `lrucache` | LRU cache |
| `functools.partial` | Partial function |
| `iitertools` | Import itertools |
| `itertools.product` | Itertools product |
| `itertools.permutations` | Itertools permutations |
| `itertools.combinations` | Itertools combinations |
| `iop` | Import operator |
| `itemgetter` | ItemGetter |
| `attrgetter` | AttrGetter |

### 4.17 Math / Statistics

| Trigger | Description |
|---------|-------------|
| `imath` | Import math |
| `mathfunc` | Math functions |
| `istats` | Import statistics |
| `statsfunc` | Statistics functions |
| `irandom` | Import random |
| `randomfunc` | Random functions |
| `ihashlib` | Import hashlib |
| `hashlib` | Hashlib functions |
| `base64` | Base64 encode/decode |

### 4.18 Path / Glob

| Trigger | Description |
|---------|-------------|
| `ipathlib` | Import pathlib |
| `path` | Path creation |
| `pathglob` | Path glob |
| `pathrglob` | Path rglob (recursive) |
| `pathread` | Path read/write text |
| `iglob` | Import glob |
| `glob` | Glob files |

### 4.19 functools

| Trigger | Description |
|---------|-------------|
| `reduce` | Reduce function |
| `cmp` | Cmp_to_key |

### 4.20 dataclasses / attrs

| Trigger | Description |
|---------|-------------|
| `dataclass` | Dataclass with fields |
| `dataclassfield` | Dataclass field |
| `iattrs` | Import attrs |
| `attrcls` | Attrs class |

### 4.21 Pyshark / Network Analysis

| Trigger | Description |
|---------|-------------|
| `ipyshark` | Import pyshark |
| `plive` | LiveCapture - Real-time packet capture |
| `pfile` | FileCapture - Read PCAP file |
| `pstat` | PCAP statistical analysis |
| `pfilter` | Display filter |
| `phttp` | HTTP protocol analysis |
| `pdns` | DNS protocol analysis |
| `ptcpstream` | TCP stream reassembly |
| `pextract` | Extract HTTP files from PCAP |
| `pcreds` | Extract credentials from PCAP |
| `pusb` | USB keyboard traffic analysis |
| `picmp` | ICMP covert channel detection |
| `pwifi` | WiFi traffic analysis |
| `pfollow` | Follow TCP stream |

---

## 5. HTML

### 4.1 Document Structure

| Trigger | Description |
|---------|-------------|
| `!` | HTML5 document type |
| `html` | HTML tag |
| `head` | Head tag |
| `body` | Body tag |

### 4.2 Head Elements

| Trigger | Description |
|---------|-------------|
| `meta` | Meta tag |
| `metau` | Meta tag (UTF-8) |
| `metav` | Meta tag (viewport) |
| `link` | Link tag (stylesheet) |
| `linkfavicon` | Link tag (favicon) |
| `title` | Title tag |
| `script` | Script tag (external) |
| `scripti` | Script tag (inline) |
| `style` | Style tag |
| `base` | Base tag |

### 4.3 Semantic Elements

| Trigger | Description |
|---------|-------------|
| `header` | Header element |
| `nav` | Navigation element |
| `main` | Main content element |
| `section` | Section element |
| `article` | Article element |
| `aside` | Aside element |
| `footer` | Footer element |
| `details` | Details/Summary element |
| `dialog` | Dialog element |
| `figure` | Figure with figcaption |
| `mark` | Marked text |
| `time` | Time element |

### 4.4 Content Elements

| Trigger | Description |
|---------|-------------|
| `div` | Div element |
| `span` | Span element |
| `p` | Paragraph |
| `h1` - `h6` | Headings 1-6 |
| `a` | Anchor link |
| `amail` | Anchor (mailto) |
| `atel` | Anchor (tel) |
| `img` | Image |
| `picture` | Picture element |
| `br` | Line break |
| `hr` | Horizontal rule |
| `blockquote` | Blockquote |
| `pre` | Preformatted text |
| `code` | Code element |
| `strong` | Strong emphasis |
| `em` | Emphasis |
| `abbr` | Abbreviation |
| `small` | Small text |
| `sub` | Subscript |
| `sup` | Superscript |

### 4.5 Lists

| Trigger | Description |
|---------|-------------|
| `ul` | Unordered list |
| `ol` | Ordered list |
| `li` | List item |
| `dl` | Description list |

### 4.6 Forms

| Trigger | Description |
|---------|-------------|
| `form` | Form element |
| `input` | Input element |
| `inputt` | Input text |
| `inpute` | Input email |
| `inputp` | Input password |
| `inputn` | Input number |
| `inputc` | Input checkbox |
| `inputr` | Input radio |
| `label` | Label element |
| `select` | Select dropdown |
| `optgroup` | Option group |
| `textarea` | Textarea |
| `button` | Button element |
| `inputf` | Input file |
| `inputd` | Input date |
| `fieldset` | Fieldset with legend |
| `output` | Output element |
| `meter` | Meter element |
| `progress` | Progress element |

### 4.7 Tables

| Trigger | Description |
|---------|-------------|
| `table` | Table element |
| `thead` | Table head |
| `tbody` | Table body |
| `tfoot` | Table footer |
| `tr` | Table row |
| `th` | Table header cell |
| `td` | Table cell |
| `caption` | Table caption |
| `colgroup` | Column group |

### 4.8 Media

| Trigger | Description |
|---------|-------------|
| `video` | Video element |
| `audio` | Audio element |
| `source` | Media source |
| `track` | Track element (subtitles) |
| `iframe` | Iframe element |
| `canvas` | Canvas element |
| `svg` | SVG element |

### 4.9 Scripting

| Trigger | Description |
|---------|-------------|
| `scriptsrc` | Script with src |
| `scriptdefer` | Script with defer |
| `scriptasync` | Script with async |
| `noscript` | Noscript element |
| `template` | Template element |

### 4.10 Common Patterns

| Trigger | Description |
|---------|-------------|
| `linkcss` | Link to CSS |
| `linkjs` | Link to JS |
| `favicon` | Favicon link |
| `viewport` | Viewport meta tag |
| `charset` | Charset meta tag |
| `desc` | Description meta tag |
| `og` | Open Graph meta tag |
| `tw` | Twitter card meta tag |
| `robots` | Robots meta tag |

### 4.11 Postfix Snippets (VSCode Emmet Style)

Usage: Type text, then add `.tag` or `#tag` suffix.

| Trigger | Description |
|---------|-------------|
| `.div` / `#div` | `<div class="..."></div>` / `<div id="..."></div>` |
| `.span` / `#span` | `<span class="..."></span>` / `<span id="..."></span>` |
| `.p` / `#p` | `<p class="..."></p>` / `<p id="..."></p>` |
| `.ul` / `#ul` | `<ul class="..."></ul>` / `<ul id="..."></ul>` |
| `.li` / `#li` | `<li class="..."></li>` / `<li id="..."></li>` |
| `.table` / `#table` | `<table class="..."></table>` / `<table id="..."></table>` |
| `.form` / `#form` | `<form class="..."></form>` / `<form id="..."></form>` |
| `.button` / `#button` | `<button class="..."></button>` / `<button id="..."></button>` |
| `.section` / `#section` | `<section class="..."></section>` / `<section id="..."></section>` |
| `.header` / `#header` | `<header class="..."></header>` / `<header id="..."></header>` |
| `.footer` / `#footer` | `<footer class="..."></footer>` / `<footer id="..."></footer>` |
| `.nav` / `#nav` | `<nav class="..."></nav>` / `<nav id="..."></nav>` |
| `.main` / `#main` | `<main class="..."></main>` / `<main id="..."></main>` |
| `.h1`-`.h6` / `#h1`-`#h6` | Headings with class/id |
| `.img` / `#img` | `<img class="...">` / `<img id="...">` |
| `.input` / `#input` | `<input class="...">` / `<input id="...">` |
| `.label` / `#label` | `<label class="..."></label>` / `<label id="..."></label>` |
| `.select` / `#select` | `<select class="..."></select>` / `<select id="..."></select>` |
| `.textarea` / `#textarea` | `<textarea class="..."></textarea>` / `<textarea id="..."></textarea>` |
| `.blockquote` / `#blockquote` | Blockquote element |
| `.pre` / `#pre` | Preformatted text |
| `.code` / `#code` | Code element |
| `.strong` / `#strong` | Strong emphasis |
| `.em` / `#em` | Emphasis |
| `.figure` / `#figure` | Figure element |
| `.details` / `#details` | Details/Summary element |
| `.dialog` / `#dialog` | Dialog element |
| `.audio` / `#audio` | Audio element |
| `.video` / `#video` | Video element |
| `.canvas` / `#canvas` | Canvas element |
| `.svg` / `#svg` | SVG element |
| `.progress` / `#progress` | Progress element |
| `.meter` / `#meter` | Meter element |
| `.template` / `#template` | Template element |

> **Note**: All HTML tags support `.tag` (class) and `#tag` (id) postfix patterns.

---

## 6. CSS

### 5.1 Selectors & Structure

| Trigger | Description |
|---------|-------------|
| `*` | Universal selector |
| `tag` | Element selector |
| `cls` | Class selector |
| `id` | ID selector |
| `attr` | Attribute selector |
| `attr=` | Attribute equals selector |
| `desc` | Descendant selector |
| `child` | Direct child selector |
| `+` | Adjacent sibling selector |
| `~` | General sibling selector |
| `group` | Selector grouping |

### 5.2 Pseudo-classes

| Trigger | Description |
|---------|-------------|
| `:hover` | Hover pseudo-class |
| `:focus` | Focus pseudo-class |
| `:active` | Active pseudo-class |
| `:visited` | Visited pseudo-class |
| `:first-child` | First child pseudo-class |
| `:last-child` | Last child pseudo-class |
| `:nth-child` | Nth child pseudo-class |
| `:not` | Not pseudo-class |
| `:checked` | Checked pseudo-class |
| `:disabled` | Disabled pseudo-class |
| `:valid` | Valid pseudo-class |
| `:invalid` | Invalid pseudo-class |
| `:root` | Root pseudo-class |

### 5.3 Pseudo-elements

| Trigger | Description |
|---------|-------------|
| `::before` | Before pseudo-element |
| `::after` | After pseudo-element |
| `::first-letter` | First letter pseudo-element |
| `::first-line` | First line pseudo-element |
| `::selection` | Selection pseudo-element |
| `::placeholder` | Placeholder pseudo-element |

### 5.4 Box Model

| Trigger | Description |
|---------|-------------|
| `margin` | Margin property |
| `padding` | Padding property |
| `width` | Width property |
| `height` | Height property |
| `max-width` | Max width property |
| `max-height` | Max height property |
| `box-sizing` | Box sizing property |
| `display` | Display property |
| `overflow` | Overflow property |

### 5.5 Layout (Flexbox & Grid)

| Trigger | Description |
|---------|-------------|
| `flex` | Flex container |
| `flex-wrap` | Flex wrap |
| `justify-content` | Justify content |
| `align-items` | Align items |
| `align-content` | Align content |
| `align-self` | Align self |
| `order` | Flex order |
| `grid` | Grid container |
| `grid-template-columns` | Grid template columns |
| `grid-template-rows` | Grid template rows |
| `grid-column` | Grid column |
| `grid-row` | Grid row |
| `gap` | Gap property |

### 5.6 Typography

| Trigger | Description |
|---------|-------------|
| `font-family` | Font family |
| `font-size` | Font size |
| `font-weight` | Font weight |
| `font-style` | Font style |
| `line-height` | Line height |
| `text-align` | Text align |
| `text-decoration` | Text decoration |
| `text-transform` | Text transform |
| `text-shadow` | Text shadow |
| `color` | Color property |

### 5.7 Background & Borders

| Trigger | Description |
|---------|-------------|
| `background` | Background property |
| `background-color` | Background color |
| `background-image` | Background image |
| `background-position` | Background position |
| `background-size` | Background size |
| `background-repeat` | Background repeat |
| `border` | Border property |
| `border-radius` | Border radius |
| `box-shadow` | Box shadow |

### 5.8 Positioning

| Trigger | Description |
|---------|-------------|
| `position` | Position property |
| `top` | Top property |
| `right` | Right property |
| `bottom` | Bottom property |
| `left` | Left property |
| `z-index` | Z index |
| `float` | Float property |
| `clear` | Clear property |

### 5.9 Transitions & Animations

| Trigger | Description |
|---------|-------------|
| `transition` | Transition property |
| `transition-duration` | Transition duration |
| `animation` | Animation property |
| `keyframes` | Keyframes rule |
| `transform` | Transform property |

### 5.10 Media Queries

| Trigger | Description |
|---------|-------------|
| `@media` | Media query |
| `@media-screen` | Media query (screen) |
| `@media-print` | Media query (print) |

### 5.11 Variables & Custom Properties

| Trigger | Description |
|---------|-------------|
| `--` | CSS custom property |
| `:root` | Root variables |
| `var` | Var function |
| `calc` | Calc function |

### 5.12 Other Properties

| Trigger | Description |
|---------|-------------|
| `opacity` | Opacity property |
| `visibility` | Visibility property |
| `cursor` | Cursor property |
| `outline` | Outline property |
| `resize` | Resize property |
| `user-select` | User select |
| `list-style` | List style |
| `content` | Content property |

---

## 7. JavaScript

### 6.1 Basic

| Trigger | Description |
|---------|-------------|
| `log` | Console log |
| `warn` | Console warn |
| `error` | Console error |
| `info` | Console info |
| `table` | Console table |
| `dir` | Console dir |
| `time` | Console time |
| `trace` | Console trace |
| `group` | Console group |

### 6.2 Variables

| Trigger | Description |
|---------|-------------|
| `const` | Const declaration |
| `let` | Let declaration |
| `var` | Var declaration |
| `destructure` | Destructuring assignment |

### 6.3 Functions

| Trigger | Description |
|---------|-------------|
| `fn` | Function declaration |
| `afn` | Arrow function |
| `afnret` | Arrow function with return |
| `iife` | Immediately invoked function |
| `asyncfn` | Async function |
| `asyncafn` | Async arrow function |
| `callback` | Callback function pattern |
| `promise` | Promise pattern |

### 6.4 Control Flow

| Trigger | Description |
|---------|-------------|
| `if` | If statement |
| `ifelse` | If else statement |
| `ternary` | Ternary operator |
| `switch` | Switch statement |
| `trycatch` | Try catch |
| `trycatchfin` | Try catch finally |
| `throw` | Throw error |

### 6.5 Loops

| Trigger | Description |
|---------|-------------|
| `for` | For loop |
| `forof` | For of loop |
| `forin` | For in loop |
| `while` | While loop |
| `dowhile` | Do while loop |
| `foreach` | ForEach method |

### 6.6 Arrays

| Trigger | Description |
|---------|-------------|
| `map` | Map method |
| `filter` | Filter method |
| `reduce` | Reduce method |
| `find` | Find method |
| `findIndex` | FindIndex method |
| `some` | Some method |
| `every` | Every method |
| `includes` | Includes method |
| `sort` | Sort method |
| `slice` | Slice method |
| `splice` | Splice method |

### 6.7 Objects

| Trigger | Description |
|---------|-------------|
| `obj` | Object literal |
| `keys` | Object.keys |
| `values` | Object.values |
| `entries` | Object.entries |
| `assign` | Object.assign |
| `freeze` | Object.freeze |

### 6.8 Classes

| Trigger | Description |
|---------|-------------|
| `class` | Class declaration |
| `classExt` | Class extends |
| `method` | Class method |
| `get` | Getter |
| `set` | Setter |
| `static` | Static method |

### 6.9 DOM

| Trigger | Description |
|---------|-------------|
| `getById` | Get element by ID |
| `getByClass` | Get elements by class |
| `getByTag` | Get elements by tag |
| `query` | Query selector |
| `queryAll` | Query selector all |
| `createEl` | Create element |
| `addEvt` | Add event listener |
| `removeEvt` | Remove event listener |
| `getAttr` | Get attribute |
| `setAttr` | Set attribute |
| `getVal` | Get value (input) |
| `setVal` | Set value (input) |
| `getText` | Get text content |
| `setText` | Set text content |
| `addClass` | Add class |
| `removeClass` | Remove class |
| `toggleClass` | Toggle class |
| `hasClass` | Has class |
| `appendChild` | Append child |
| `setStyle` | Set style |

### 6.10 Events

| Trigger | Description |
|---------|-------------|
| `onclick` | Click event |
| `onchange` | Change event |
| `oninput` | Input event |
| `onsubmit` | Submit event |
| `onload` | Load event |
| `preventDefault` | Prevent default |
| `stopProp` | Stop propagation |

### 6.11 Timing

| Trigger | Description |
|---------|-------------|
| `setTimeout` | Set timeout |
| `setInterval` | Set interval |
| `debounce` | Debounce function |
| `throttle` | Throttle function |

### 6.12 JSON

| Trigger | Description |
|---------|-------------|
| `parse` | JSON.parse |
| `stringify` | JSON.stringify |

### 6.13 Storage

| Trigger | Description |
|---------|-------------|
| `localGet` | LocalStorage getItem |
| `localSet` | LocalStorage setItem |
| `localRemove` | LocalStorage removeItem |
| `localClear` | LocalStorage clear |
| `sessionGet` | SessionStorage getItem |
| `sessionSet` | SessionStorage setItem |

### 6.14 Async / Await

| Trigger | Description |
|---------|-------------|
| `await` | Await promise |
| `promiseAll` | Promise.all |
| `fetch` | Fetch API |
| `fetchAsync` | Fetch API (async/await) |

### 6.15 ES6+ Features

| Trigger | Description |
|---------|-------------|
| `export` | Export default |
| `exportn` | Named export |
| `import` | Import default |
| `importn` | Named import |
| `importas` | Import as |
| `module` | Module script |

### 6.16 Strings

| Trigger | Description |
|---------|-------------|
| `includes` | String includes |
| `startsWith` | String startsWith |
| `endsWith` | String endsWith |
| `replace` | String replace |
| `trim` | String trim |
| `split` | String split |

