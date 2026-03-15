local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local postfix = require('luasnip.extras.postfix').postfix

return {
    ---------------------------------------
    -- 1. Document Structure
    ---------------------------------------

    s({ trig = '!', dscr = 'HTML5 document type' },
        t({ '<!DOCTYPE html>', '<html lang="en">', '<head>', '    <meta charset="UTF-8">',
            '    <meta name="viewport" content="width=device-width, initial-scale=1.0">', '    <title>Document</title>',
            '</head>', '<body>', '    ', '</body>', '</html>' })
    ),

    s({ trig = 'html', dscr = 'HTML tag' },
        fmt([[
<html>
    {}
</html>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'head', dscr = 'Head tag' },
        fmt([[
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    {}
</head>
]],
            {
                i(0, '<title>Title</title>'),
            }
        )
    ),

    s({ trig = 'body', dscr = 'Body tag' },
        fmt([[
<body>
    {}
</body>
]],
            {
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 2. Head Elements
    ---------------------------------------

    s({ trig = 'meta', dscr = 'Meta tag' },
        fmt([[
<meta name="{}" content="{}">
]],
            {
                i(1, 'description'),
                i(0, 'content'),
            }
        )
    ),

    s({ trig = 'metau', dscr = 'Meta tag (UTF-8)' },
        t('<meta charset="UTF-8">')
    ),

    s({ trig = 'metav', dscr = 'Meta tag (viewport)' },
        t('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
    ),

    s({ trig = 'link', dscr = 'Link tag (stylesheet)' },
        fmt([[
<link rel="stylesheet" href="{}">
]],
            {
                i(0, 'style.css'),
            }
        )
    ),

    s({ trig = 'linkfavicon', dscr = 'Link tag (favicon)' },
        fmt([[
<link rel="icon" type="image/x-icon" href="{}">
]],
            {
                i(0, '/favicon.ico'),
            }
        )
    ),

    s({ trig = 'title', dscr = 'Title tag' },
        fmt([[
<title>{}</title>
]],
            {
                i(0, 'Title'),
            }
        )
    ),

    s({ trig = 'script', dscr = 'Script tag (external)' },
        fmt([[
<script src="{}.js"></script>
]],
            {
                i(0, 'app'),
            }
        )
    ),

    s({ trig = 'scripti', dscr = 'Script tag (inline)' },
        fmt([[
<script>
    {}
</script>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'style', dscr = 'Style tag' },
        fmt([[
<style>
    {}
</style>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'base', dscr = 'Base tag' },
        fmt([[
<base href="{}" target="{}">
]],
            {
                i(1, '/'),
                i(0, '_blank'),
            }
        )
    ),

    ---------------------------------------
    -- 3. Semantic Elements
    ---------------------------------------

    s({ trig = 'header', dscr = 'Header element' },
        fmt([[
<header>
    {}
</header>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'nav', dscr = 'Navigation element' },
        fmt([[
<nav>
    {}
</nav>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'main', dscr = 'Main content element' },
        fmt([[
<main>
    {}
</main>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'section', dscr = 'Section element' },
        fmt([[
<section>
    {}
</section>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'article', dscr = 'Article element' },
        fmt([[
<article>
    {}
</article>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'aside', dscr = 'Aside element' },
        fmt([[
<aside>
    {}
</aside>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'footer', dscr = 'Footer element' },
        fmt([[
<footer>
    {}
</footer>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'details', dscr = 'Details/Summary element' },
        fmt([[
<details>
    <summary>{}</summary>
    {}
</details>
]],
            {
                i(1, 'Click to expand'),
                i(0),
            }
        )
    ),

    s({ trig = 'dialog', dscr = 'Dialog element' },
        fmt([[
<dialog>
    {}
</dialog>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'figure', dscr = 'Figure with figcaption' },
        fmt([[
<figure>
    {}
    <figcaption>{}</figcaption>
</figure>
]],
            {
                i(1, '<img src="" alt="">'),
                i(0, 'Caption'),
            }
        )
    ),

    s({ trig = 'mark', dscr = 'Marked text' },
        fmt([[
<mark>{}</mark>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'time', dscr = 'Time element' },
        fmt([[
<time datetime="{}">{}</time>
]],
            {
                i(1, '2024-01-01'),
                i(0, 'January 1, 2024'),
            }
        )
    ),

    ---------------------------------------
    -- 4. Content Elements
    ---------------------------------------

    s({ trig = 'div', dscr = 'Div element' },
        fmt([[
<div>
    {}
</div>
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'span', dscr = 'Span element' },
        fmt([[
<span>{}</span>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'p', dscr = 'Paragraph' },
        fmt([[
<p>{}</p>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'h1', dscr = 'Heading 1' },
        fmt([[
<h1>{}</h1>
]],
            {
                i(0, 'Heading'),
            }
        )
    ),

    s({ trig = 'h2', dscr = 'Heading 2' },
        fmt([[
<h2>{}</h2>
]],
            {
                i(0, 'Heading'),
            }
        )
    ),

    s({ trig = 'h3', dscr = 'Heading 3' },
        fmt([[
<h3>{}</h3>
]],
            {
                i(0, 'Heading'),
            }
        )
    ),

    s({ trig = 'h4', dscr = 'Heading 4' },
        fmt([[
<h4>{}</h4>
]],
            {
                i(0, 'Heading'),
            }
        )
    ),

    s({ trig = 'h5', dscr = 'Heading 5' },
        fmt([[
<h5>{}</h5>
]],
            {
                i(0, 'Heading'),
            }
        )
    ),

    s({ trig = 'h6', dscr = 'Heading 6' },
        fmt([[
<h6>{}</h6>
]],
            {
                i(0, 'Heading'),
            }
        )
    ),

    s({ trig = 'a', dscr = 'Anchor link' },
        fmt([[
<a href="{}">{}</a>
]],
            {
                i(1, 'url'),
                i(0, 'link text'),
            }
        )
    ),

    s({ trig = 'amail', dscr = 'Anchor (mailto)' },
        fmt([[
<a href="mailto:{}">{}</a>
]],
            {
                i(1, 'email@example.com'),
                i(0, 'Email'),
            }
        )
    ),

    s({ trig = 'atel', dscr = 'Anchor (tel)' },
        fmt([[
<a href="tel:{}">{}</a>
]],
            {
                i(1, '+1234567890'),
                i(0, 'Phone'),
            }
        )
    ),

    s({ trig = 'img', dscr = 'Image' },
        fmt([[
<img src="{}" alt="{}">
]],
            {
                i(1, 'image.jpg'),
                i(0, 'description'),
            }
        )
    ),

    s({ trig = 'picture', dscr = 'Picture element' },
        fmt([[
<picture>
    <source media="(min-width: {})" srcset="{}">
    <img src="{}" alt="{}">
</picture>
]],
            {
                i(1, '800px'),
                i(2, 'large.jpg'),
                i(3, 'small.jpg'),
                i(0, 'description'),
            }
        )
    ),

    s({ trig = 'br', dscr = 'Line break' },
        t('<br>')
    ),

    s({ trig = 'hr', dscr = 'Horizontal rule' },
        t('<hr>')
    ),

    s({ trig = 'blockquote', dscr = 'Blockquote' },
        fmt([[
<blockquote>
    {}
</blockquote>
]],
            {
                i(0, 'quote'),
            }
        )
    ),

    s({ trig = 'pre', dscr = 'Preformatted text' },
        fmt([[
<pre>
{}
</pre>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'code', dscr = 'Code element' },
        fmt([[
<code>{}</code>
]],
            {
                i(0, 'code'),
            }
        )
    ),

    s({ trig = 'strong', dscr = 'Strong emphasis' },
        fmt([[
<strong>{}</strong>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'em', dscr = 'Emphasis' },
        fmt([[
<em>{}</em>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'abbr', dscr = 'Abbreviation' },
        fmt([[
<abbr title="{}">{}</abbr>
]],
            {
                i(1, 'Full form'),
                i(0, 'Abbr'),
            }
        )
    ),

    s({ trig = 'small', dscr = 'Small text' },
        fmt([[
<small>{}</small>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'sub', dscr = 'Subscript' },
        fmt([[
<sub>{}</sub>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'sup', dscr = 'Superscript' },
        fmt([[
<sup>{}</sup>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    ---------------------------------------
    -- 5. Lists
    ---------------------------------------

    s({ trig = 'ul', dscr = 'Unordered list' },
        fmt([[
<ul>
    <li>{}</li>
</ul>
]],
            {
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'ol', dscr = 'Ordered list' },
        fmt([[
<ol>
    <li>{}</li>
</ol>
]],
            {
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'li', dscr = 'List item' },
        fmt([[
<li>{}</li>
]],
            {
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'dl', dscr = 'Description list' },
        fmt([[
<dl>
    <dt>{}</dt>
    <dd>{}</dd>
</dl>
]],
            {
                i(1, 'term'),
                i(0, 'description'),
            }
        )
    ),

    ---------------------------------------
    -- 6. Forms
    ---------------------------------------

    s({ trig = 'form', dscr = 'Form element' },
        fmt([[
<form action="{}" method="{}">
    {}
</form>
]],
            {
                i(1, '/submit'),
                i(2, 'post'),
                i(0),
            }
        )
    ),

    s({ trig = 'input', dscr = 'Input element' },
        fmt([[
<input type="{}" name="{}" id="{}"{}>
]],
            {
                c(1,
                    { t('text'), t('password'), t('email'), t('number'), t('checkbox'), t('radio'), t('file'), t(
                        'hidden'), t('submit'), t('button'), t('reset'), t('color'), t('date'), t('time'), t('url') }),
                i(2, 'name'),
                i(3, 'id'),
                i(0, ''),
            }
        )
    ),

    s({ trig = 'inputt', dscr = 'Input text' },
        fmt([[
<input type="text" name="{}" id="{}" placeholder="{}">
]],
            {
                i(1, 'field'),
                i(2, 'field'),
                i(0, 'Placeholder'),
            }
        )
    ),

    s({ trig = 'inpute', dscr = 'Input email' },
        fmt([[
<input type="email" name="{}" id="{}" placeholder="{}">
]],
            {
                i(1, 'email'),
                i(2, 'email'),
                i(0, 'email@example.com'),
            }
        )
    ),

    s({ trig = 'inputp', dscr = 'Input password' },
        fmt([[
<input type="password" name="{}" id="{}" placeholder="{}">
]],
            {
                i(1, 'password'),
                i(2, 'password'),
                i(0, 'Password'),
            }
        )
    ),

    s({ trig = 'inputn', dscr = 'Input number' },
        fmt([[
<input type="number" name="{}" id="{}" min="{}" max="{}">
]],
            {
                i(1, 'number'),
                i(2, 'number'),
                i(3, '0'),
                i(0, '100'),
            }
        )
    ),

    s({ trig = 'inputc', dscr = 'Input checkbox' },
        fmt([[
<input type="checkbox" name="{}" id="{}"> <label for="{}">{}</label>
]],
            {
                i(1, 'checkbox'),
                i(2, 'checkbox'),
                rep(2),
                i(0, 'Label'),
            }
        )
    ),

    s({ trig = 'inputr', dscr = 'Input radio' },
        fmt([[
<input type="radio" name="{}" id="{}" value="{}"> <label for="{}">{}</label>
]],
            {
                i(1, 'radio'),
                i(2, 'radio1'),
                i(3, 'value1'),
                rep(2),
                i(0, 'Label'),
            }
        )
    ),

    s({ trig = 'label', dscr = 'Label element' },
        fmt([[
<label for="{}">{}</label>
]],
            {
                i(1, 'id'),
                i(0, 'Label'),
            }
        )
    ),

    s({ trig = 'select', dscr = 'Select dropdown' },
        fmt([[
<select name="{}" id="{}">
    <option value="{}">{}</option>
</select>
]],
            {
                i(1, 'select'),
                i(2, 'select'),
                i(3, 'value'),
                i(0, 'Option'),
            }
        )
    ),

    s({ trig = 'optgroup', dscr = 'Option group' },
        fmt([[
<optgroup label="{}">
    <option value="{}">{}</option>
</optgroup>
]],
            {
                i(1, 'Group'),
                i(2, 'value'),
                i(0, 'Option'),
            }
        )
    ),

    s({ trig = 'textarea', dscr = 'Textarea' },
        fmt([[
<textarea name="{}" id="{}" rows="{}" placeholder="{}">{}</textarea>
]],
            {
                i(1, 'textarea'),
                i(2, 'textarea'),
                i(3, '4'),
                i(4, 'Placeholder'),
                i(0),
            }
        )
    ),

    s({ trig = 'button', dscr = 'Button element' },
        fmt([[
<button type="{}">{}</button>
]],
            {
                c(1, { t('submit'), t('button'), t('reset') }),
                i(0, 'Click me'),
            }
        )
    ),

    s({ trig = 'inputf', dscr = 'Input file' },
        fmt([[
<input type="file" name="{}" id="{}" accept="{}">
]],
            {
                i(1, 'file'),
                i(2, 'file'),
                i(0, '.pdf,.doc,.docx'),
            }
        )
    ),

    s({ trig = 'inputd', dscr = 'Input date' },
        fmt([[
<input type="date" name="{}" id="{}">
]],
            {
                i(1, 'date'),
                i(0, 'date'),
            }
        )
    ),

    s({ trig = 'fieldset', dscr = 'Fieldset with legend' },
        fmt([[
<fieldset>
    <legend>{}</legend>
    {}
</fieldset>
]],
            {
                i(1, 'Legend'),
                i(0),
            }
        )
    ),

    s({ trig = 'output', dscr = 'Output element' },
        fmt([[
<output name="{}" for="{}">{}</output>
]],
            {
                i(1, 'result'),
                i(2, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = 'meter', dscr = 'Meter element' },
        fmt([[
<meter value="{}" min="{}" max="{}">{}</meter>
]],
            {
                i(1, '50'),
                i(2, '0'),
                i(3, '100'),
                i(0, '50%'),
            }
        )
    ),

    s({ trig = 'progress', dscr = 'Progress element' },
        fmt([[
<progress value="{}" max="{}">{}</progress>
]],
            {
                i(1, '50'),
                i(2, '100'),
                i(0, '50%'),
            }
        )
    ),

    ---------------------------------------
    -- 7. Tables
    ---------------------------------------

    s({ trig = 'table', dscr = 'Table element' },
        fmt([[
<table>
    {}
</table>
]],
            {
                i(0, '<tr><td>Cell</td></tr>'),
            }
        )
    ),

    s({ trig = 'thead', dscr = 'Table head' },
        fmt([[
<thead>
    <tr>
        <th>{}</th>
    </tr>
</thead>
]],
            {
                i(0, 'Header'),
            }
        )
    ),

    s({ trig = 'tbody', dscr = 'Table body' },
        fmt([[
<tbody>
    <tr>
        <td>{}</td>
    </tr>
</tbody>
]],
            {
                i(0, 'Cell'),
            }
        )
    ),

    s({ trig = 'tfoot', dscr = 'Table footer' },
        fmt([[
<tfoot>
    <tr>
        <td>{}</td>
    </tr>
</tfoot>
]],
            {
                i(0, 'Footer'),
            }
        )
    ),

    s({ trig = 'tr', dscr = 'Table row' },
        fmt([[
<tr>
    <td>{}</td>
</tr>
]],
            {
                i(0, 'Cell'),
            }
        )
    ),

    s({ trig = 'th', dscr = 'Table header cell' },
        fmt([[
<th scope="{}">{}</th>
]],
            {
                c(1, { t('col'), t('row'), t('colgroup'), t('rowgroup') }),
                i(0, 'Header'),
            }
        )
    ),

    s({ trig = 'td', dscr = 'Table cell' },
        fmt([[
<td>{}</td>
]],
            {
                i(0, 'Cell'),
            }
        )
    ),

    s({ trig = 'caption', dscr = 'Table caption' },
        fmt([[
<caption>{}</caption>
]],
            {
                i(0, 'Caption'),
            }
        )
    ),

    s({ trig = 'colgroup', dscr = 'Column group' },
        fmt([[
<colgroup>
    <col span="{}">
</colgroup>
]],
            {
                i(0, '1'),
            }
        )
    ),

    ---------------------------------------
    -- 8. Media
    ---------------------------------------

    s({ trig = 'video', dscr = 'Video element' },
        fmt([[
<video width="{}" height="{}" controls>
    <source src="{}" type="video/{}">
    Your browser does not support the video tag.
</video>
]],
            {
                i(1, '320'),
                i(2, '240'),
                i(3, 'video.mp4'),
                i(0, 'mp4'),
            }
        )
    ),

    s({ trig = 'audio', dscr = 'Audio element' },
        fmt([[
<audio controls>
    <source src="{}" type="audio/{}">
    Your browser does not support the audio tag.
</audio>
]],
            {
                i(1, 'audio.mp3'),
                i(0, 'mpeg'),
            }
        )
    ),

    s({ trig = 'source', dscr = 'Media source' },
        fmt([[
<source src="{}" type="{}">
]],
            {
                i(1, 'media.mp4'),
                i(0, 'video/mp4'),
            }
        )
    ),

    s({ trig = 'track', dscr = 'Track element (subtitles)' },
        fmt([[
<track kind="{}" src="{}" srclang="{}" label="{}">
]],
            {
                c(1, { t('subtitles'), t('captions'), t('descriptions'), t('chapters'), t('metadata') }),
                i(2, 'subtitles.vtt'),
                i(3, 'en'),
                i(0, 'English'),
            }
        )
    ),

    s({ trig = 'iframe', dscr = 'Iframe element' },
        fmt([[
<iframe src="{}" title="{}" width="{}" height="{}" frameborder="{}">{}</iframe>
]],
            {
                i(1, 'https://example.com'),
                i(2, 'Description'),
                i(3, '400'),
                i(4, '300'),
                i(5, '0'),
                i(0),
            }
        )
    ),

    s({ trig = 'canvas', dscr = 'Canvas element' },
        fmt([[
<canvas id="{}" width="{}" height="{}">{}</canvas>
]],
            {
                i(1, 'myCanvas'),
                i(2, '150'),
                i(3, '150'),
                i(0, 'Fallback text'),
            }
        )
    ),

    s({ trig = 'svg', dscr = 'SVG element' },
        fmt([[
<svg width="{}" height="{}" viewBox="0 0 {} {}" xmlns="http://www.w3.org/2000/svg">
    {}
</svg>
]],
            {
                i(1, '100'),
                i(2, '100'),
                i(3, '100'),
                i(4, '100'),
                i(0, '<circle cx="50" cy="50" r="40" fill="red" />'),
            }
        )
    ),

    ---------------------------------------
    -- 9. Scripting
    ---------------------------------------

    s({ trig = 'scriptsrc', dscr = 'Script with src' },
        fmt([[
<script src="{}"{}></script>
]],
            {
                i(1, 'app.js'),
                i(0, ''),
            }
        )
    ),

    s({ trig = 'scriptdefer', dscr = 'Script with defer' },
        fmt([[
<script src="{}" defer></script>
]],
            {
                i(0, 'app.js'),
            }
        )
    ),

    s({ trig = 'scriptasync', dscr = 'Script with async' },
        fmt([[
<script src="{}" async></script>
]],
            {
                i(0, 'app.js'),
            }
        )
    ),

    s({ trig = 'noscript', dscr = 'Noscript element' },
        fmt([[
<noscript>
    {}
</noscript>
]],
            {
                i(0, 'JavaScript is required'),
            }
        )
    ),

    s({ trig = 'template', dscr = 'Template element' },
        fmt([[
<template id="{}">
    {}
</template>
]],
            {
                i(1, 'my-template'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 10. Embedded Content
    ---------------------------------------

    s({ trig = 'embed', dscr = 'Embed element' },
        fmt([[
<embed src="{}" type="{}" width="{}" height="{}">
]],
            {
                i(1, 'file'),
                i(2, 'type'),
                i(3, '100'),
                i(0, '100'),
            }
        )
    ),

    s({ trig = 'object', dscr = 'Object element' },
        fmt([[
<object data="{}" type="{}" width="{}" height="{}">
    {}
</object>
]],
            {
                i(1, 'file.pdf'),
                i(2, 'application/pdf'),
                i(3, '300'),
                i(4, '400'),
                i(0, 'Fallback'),
            }
        )
    ),

    s({ trig = 'param', dscr = 'Param element' },
        fmt([[
<param name="{}" value="{}">
]],
            {
                i(1, 'name'),
                i(0, 'value'),
            }
        )
    ),

    ---------------------------------------
    -- 11. Common Patterns
    ---------------------------------------

    s({ trig = 'linkcss', dscr = 'Link to CSS' },
        fmt([[
<link rel="stylesheet" href="{}.css">
]],
            {
                i(0, 'styles'),
            }
        )
    ),

    s({ trig = 'linkjs', dscr = 'Link to JS' },
        fmt([[
<script src="{}.js"></script>
]],
            {
                i(0, 'script'),
            }
        )
    ),

    s({ trig = 'favicon', dscr = 'Favicon link' },
        fmt([[
<link rel="icon" href="{}" type="image/{}">
]],
            {
                i(1, 'favicon.ico'),
                i(0, 'x-icon'),
            }
        )
    ),

    s({ trig = 'apple-touch-icon', dscr = 'Apple touch icon' },
        fmt([[
<link rel="apple-touch-icon" sizes="{}" href="{}">
]],
            {
                i(1, '180x180'),
                i(0, 'apple-touch-icon.png'),
            }
        )
    ),

    s({ trig = 'viewport', dscr = 'Viewport meta tag' },
        t('<meta name="viewport" content="width=device-width, initial-scale=1.0">')
    ),

    s({ trig = 'charset', dscr = 'Charset meta tag' },
        t('<meta charset="UTF-8">')
    ),

    s({ trig = 'desc', dscr = 'Description meta tag' },
        fmt([[
<meta name="description" content="{}">
]],
            {
                i(0, 'Page description'),
            }
        )
    ),

    s({ trig = 'og', dscr = 'Open Graph meta tag' },
        fmt([[
<meta property="og:{}" content="{}">
]],
            {
                i(1, 'title'),
                i(0, 'content'),
            }
        )
    ),

    s({ trig = 'tw', dscr = 'Twitter card meta tag' },
        fmt([[
<meta name="twitter:{}" content="{}">
]],
            {
                i(1, 'card'),
                i(0, 'content'),
            }
        )
    ),

    s({ trig = 'robots', dscr = 'Robots meta tag' },
        fmt([[
<meta name="robots" content="{}">
]],
            {
                i(0, 'index, follow'),
            }
        )
    ),

    s({ trig = 'icon', dscr = 'Favicon link (short)' },
        fmt([[
<link rel="icon" href="{}">
]],
            {
                i(0, 'favicon.ico'),
            }
        )
    ),

    s({ trig = 'data', dscr = 'Data element' },
        fmt([[
<data value="{}">{}</data>
]],
            {
                i(1, '123'),
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'ruby', dscr = 'Ruby annotation' },
        fmt([[
<ruby>
    {}<rt>{}</rt>
</ruby>
]],
            {
                i(1, 'base'),
                i(0, 'annotation'),
            }
        )
    ),

    s({ trig = 'bdo', dscr = 'Bidirectional override' },
        fmt([[
<bdo dir="{}">{}</bdo>
]],
            {
                c(1, { t('ltr'), t('rtl') }),
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'ins', dscr = 'Inserted text' },
        fmt([[
<ins>{}</ins>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'del', dscr = 'Deleted text' },
        fmt([[
<del>{}</del>
]],
            {
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'samp', dscr = 'Sample output' },
        fmt([[
<samp>{}</samp>
]],
            {
                i(0, 'sample'),
            }
        )
    ),

    s({ trig = 'kbd', dscr = 'Keyboard input' },
        fmt([[
<kbd>{}</kbd>
]],
            {
                i(0, 'Ctrl+C'),
            }
        )
    ),

    s({ trig = 'var', dscr = 'Variable' },
        fmt([[
<var>{}</var>
]],
            {
                i(0, 'variable'),
            }
        )
    ),

    s({ trig = 'cite', dscr = 'Citation' },
        fmt([[
<cite>{}</cite>
]],
            {
                i(0, 'title'),
            }
        )
    ),

    s({ trig = 'q', dscr = 'Inline quote' },
        fmt([[
<q cite="{}">{}</q>
]],
            {
                i(1, 'url'),
                i(0, 'quote'),
            }
        )
    ),

    s({ trig = 'dfn', dscr = 'Definition' },
        fmt([[
<dfn title="{}">{}</dfn>
]],
            {
                i(1, 'definition'),
                i(0, 'term'),
            }
        )
    ),

    ---------------------------------------
    -- 12. Postfix Snippets (VSCode Emmet Style)
    -- Usage: Type text, then add .tag or #tag suffix
    -- Example: "container" + ".div" → <div class="container"></div>
    ---------------------------------------

    -- div
    postfix(".div", {
        f(function(_, parent)
            return '<div class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></div>'
        end, {})
    }),
    postfix("#div", {
        f(function(_, parent)
            return '<div id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></div>'
        end, {})
    }),

    -- span
    postfix(".span", {
        f(function(_, parent)
            return '<span class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></span>'
        end, {})
    }),
    postfix("#span", {
        f(function(_, parent)
            return '<span id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></span>'
        end, {})
    }),

    -- p (paragraph)
    postfix(".p", {
        f(function(_, parent)
            return '<p class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></p>'
        end, {})
    }),
    postfix("#p", {
        f(function(_, parent)
            return '<p id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></p>'
        end, {})
    }),

    -- a (anchor)
    postfix(".a", {
        f(function(_, parent)
            return '<a class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></a>'
        end, {})
    }),
    postfix("#a", {
        f(function(_, parent)
            return '<a id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></a>'
        end, {})
    }),

    -- ul (unordered list)
    postfix(".ul", {
        f(function(_, parent)
            return '<ul class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></ul>'
        end, {})
    }),
    postfix("#ul", {
        f(function(_, parent)
            return '<ul id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></ul>'
        end, {})
    }),

    -- ol (ordered list)
    postfix(".ol", {
        f(function(_, parent)
            return '<ol class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></ol>'
        end, {})
    }),
    postfix("#ol", {
        f(function(_, parent)
            return '<ol id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></ol>'
        end, {})
    }),

    -- li (list item)
    postfix(".li", {
        f(function(_, parent)
            return '<li class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></li>'
        end, {})
    }),
    postfix("#li", {
        f(function(_, parent)
            return '<li id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></li>'
        end, {})
    }),

    -- table
    postfix(".table", {
        f(function(_, parent)
            return '<table class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></table>'
        end, {})
    }),
    postfix("#table", {
        f(function(_, parent)
            return '<table id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></table>'
        end, {})
    }),

    -- tr (table row)
    postfix(".tr", {
        f(function(_, parent)
            return '<tr class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></tr>'
        end, {})
    }),
    postfix("#tr", {
        f(function(_, parent)
            return '<tr id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></tr>'
        end, {})
    }),

    -- td (table data)
    postfix(".td", {
        f(function(_, parent)
            return '<td class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></td>'
        end, {})
    }),
    postfix("#td", {
        f(function(_, parent)
            return '<td id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></td>'
        end, {})
    }),

    -- th (table header)
    postfix(".th", {
        f(function(_, parent)
            return '<th class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></th>'
        end, {})
    }),
    postfix("#th", {
        f(function(_, parent)
            return '<th id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></th>'
        end, {})
    }),

    -- form
    postfix(".form", {
        f(function(_, parent)
            return '<form class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></form>'
        end, {})
    }),
    postfix("#form", {
        f(function(_, parent)
            return '<form id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></form>'
        end, {})
    }),

    -- input
    postfix(".input", {
        f(function(_, parent)
            return '<input class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#input", {
        f(function(_, parent)
            return '<input id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- button
    postfix(".button", {
        f(function(_, parent)
            return '<button class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></button>'
        end, {})
    }),
    postfix("#button", {
        f(function(_, parent)
            return '<button id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></button>'
        end, {})
    }),

    -- section
    postfix(".section", {
        f(function(_, parent)
            return '<section class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></section>'
        end, {})
    }),
    postfix("#section", {
        f(function(_, parent)
            return '<section id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></section>'
        end, {})
    }),

    -- article
    postfix(".article", {
        f(function(_, parent)
            return '<article class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></article>'
        end, {})
    }),
    postfix("#article", {
        f(function(_, parent)
            return '<article id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></article>'
        end, {})
    }),

    -- header
    postfix(".header", {
        f(function(_, parent)
            return '<header class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></header>'
        end, {})
    }),
    postfix("#header", {
        f(function(_, parent)
            return '<header id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></header>'
        end, {})
    }),

    -- footer
    postfix(".footer", {
        f(function(_, parent)
            return '<footer class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></footer>'
        end, {})
    }),
    postfix("#footer", {
        f(function(_, parent)
            return '<footer id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></footer>'
        end, {})
    }),

    -- nav
    postfix(".nav", {
        f(function(_, parent)
            return '<nav class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></nav>'
        end, {})
    }),
    postfix("#nav", {
        f(function(_, parent)
            return '<nav id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></nav>'
        end, {})
    }),

    -- main
    postfix(".main", {
        f(function(_, parent)
            return '<main class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></main>'
        end, {})
    }),
    postfix("#main", {
        f(function(_, parent)
            return '<main id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></main>'
        end, {})
    }),

    -- h1-h6 headings
    postfix(".h1", {
        f(function(_, parent)
            return '<h1 class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h1>'
        end, {})
    }),
    postfix("#h1", {
        f(function(_, parent)
            return '<h1 id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h1>'
        end, {})
    }),
    postfix(".h2", {
        f(function(_, parent)
            return '<h2 class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h2>'
        end, {})
    }),
    postfix("#h2", {
        f(function(_, parent)
            return '<h2 id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h2>'
        end, {})
    }),
    postfix(".h3", {
        f(function(_, parent)
            return '<h3 class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h3>'
        end, {})
    }),
    postfix("#h3", {
        f(function(_, parent)
            return '<h3 id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h3>'
        end, {})
    }),
    postfix(".h4", {
        f(function(_, parent)
            return '<h4 class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h4>'
        end, {})
    }),
    postfix("#h4", {
        f(function(_, parent)
            return '<h4 id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h4>'
        end, {})
    }),
    postfix(".h5", {
        f(function(_, parent)
            return '<h5 class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h5>'
        end, {})
    }),
    postfix("#h5", {
        f(function(_, parent)
            return '<h5 id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h5>'
        end, {})
    }),
    postfix(".h6", {
        f(function(_, parent)
            return '<h6 class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h6>'
        end, {})
    }),
    postfix("#h6", {
        f(function(_, parent)
            return '<h6 id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></h6>'
        end, {})
    }),

    -- img
    postfix(".img", {
        f(function(_, parent)
            return '<img class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#img", {
        f(function(_, parent)
            return '<img id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- iframe
    postfix(".iframe", {
        f(function(_, parent)
            return '<iframe class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></iframe>'
        end, {})
    }),
    postfix("#iframe", {
        f(function(_, parent)
            return '<iframe id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></iframe>'
        end, {})
    }),

    -- label
    postfix(".label", {
        f(function(_, parent)
            return '<label class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></label>'
        end, {})
    }),
    postfix("#label", {
        f(function(_, parent)
            return '<label id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></label>'
        end, {})
    }),

    -- select
    postfix(".select", {
        f(function(_, parent)
            return '<select class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></select>'
        end, {})
    }),
    postfix("#select", {
        f(function(_, parent)
            return '<select id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></select>'
        end, {})
    }),

    -- textarea
    postfix(".textarea", {
        f(function(_, parent)
            return '<textarea class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></textarea>'
        end, {})
    }),
    postfix("#textarea", {
        f(function(_, parent)
            return '<textarea id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></textarea>'
        end, {})
    }),

    -- blockquote
    postfix(".blockquote", {
        f(function(_, parent)
            return '<blockquote class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></blockquote>'
        end, {})
    }),
    postfix("#blockquote", {
        f(function(_, parent)
            return '<blockquote id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></blockquote>'
        end, {})
    }),

    -- pre (preformatted)
    postfix(".pre", {
        f(function(_, parent)
            return '<pre class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></pre>'
        end, {})
    }),
    postfix("#pre", {
        f(function(_, parent)
            return '<pre id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></pre>'
        end, {})
    }),

    -- code
    postfix(".code", {
        f(function(_, parent)
            return '<code class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></code>'
        end, {})
    }),
    postfix("#code", {
        f(function(_, parent)
            return '<code id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></code>'
        end, {})
    }),

    -- strong
    postfix(".strong", {
        f(function(_, parent)
            return '<strong class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></strong>'
        end, {})
    }),
    postfix("#strong", {
        f(function(_, parent)
            return '<strong id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></strong>'
        end, {})
    }),

    -- em (emphasis)
    postfix(".em", {
        f(function(_, parent)
            return '<em class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></em>'
        end, {})
    }),
    postfix("#em", {
        f(function(_, parent)
            return '<em id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></em>'
        end, {})
    }),

    -- small
    postfix(".small", {
        f(function(_, parent)
            return '<small class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></small>'
        end, {})
    }),
    postfix("#small", {
        f(function(_, parent)
            return '<small id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></small>'
        end, {})
    }),

    -- del (deleted)
    postfix(".del", {
        f(function(_, parent)
            return '<del class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></del>'
        end, {})
    }),
    postfix("#del", {
        f(function(_, parent)
            return '<del id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></del>'
        end, {})
    }),

    -- ins (inserted)
    postfix(".ins", {
        f(function(_, parent)
            return '<ins class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></ins>'
        end, {})
    }),
    postfix("#ins", {
        f(function(_, parent)
            return '<ins id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></ins>'
        end, {})
    }),

    -- sub (subscript)
    postfix(".sub", {
        f(function(_, parent)
            return '<sub class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></sub>'
        end, {})
    }),
    postfix("#sub", {
        f(function(_, parent)
            return '<sub id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></sub>'
        end, {})
    }),

    -- sup (superscript)
    postfix(".sup", {
        f(function(_, parent)
            return '<sup class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></sup>'
        end, {})
    }),
    postfix("#sup", {
        f(function(_, parent)
            return '<sup id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></sup>'
        end, {})
    }),

    -- figure
    postfix(".figure", {
        f(function(_, parent)
            return '<figure class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></figure>'
        end, {})
    }),
    postfix("#figure", {
        f(function(_, parent)
            return '<figure id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></figure>'
        end, {})
    }),

    -- figcaption
    postfix(".figcaption", {
        f(function(_, parent)
            return '<figcaption class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></figcaption>'
        end, {})
    }),
    postfix("#figcaption", {
        f(function(_, parent)
            return '<figcaption id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></figcaption>'
        end, {})
    }),

    -- dialog
    postfix(".dialog", {
        f(function(_, parent)
            return '<dialog class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></dialog>'
        end, {})
    }),
    postfix("#dialog", {
        f(function(_, parent)
            return '<dialog id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></dialog>'
        end, {})
    }),

    -- details
    postfix(".details", {
        f(function(_, parent)
            return '<details class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></details>'
        end, {})
    }),
    postfix("#details", {
        f(function(_, parent)
            return '<details id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></details>'
        end, {})
    }),

    -- summary
    postfix(".summary", {
        f(function(_, parent)
            return '<summary class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></summary>'
        end, {})
    }),
    postfix("#summary", {
        f(function(_, parent)
            return '<summary id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></summary>'
        end, {})
    }),

    -- time
    postfix(".time", {
        f(function(_, parent)
            return '<time class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></time>'
        end, {})
    }),
    postfix("#time", {
        f(function(_, parent)
            return '<time id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></time>'
        end, {})
    }),

    -- mark
    postfix(".mark", {
        f(function(_, parent)
            return '<mark class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></mark>'
        end, {})
    }),
    postfix("#mark", {
        f(function(_, parent)
            return '<mark id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></mark>'
        end, {})
    }),

    -- abbr
    postfix(".abbr", {
        f(function(_, parent)
            return '<abbr class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></abbr>'
        end, {})
    }),
    postfix("#abbr", {
        f(function(_, parent)
            return '<abbr id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></abbr>'
        end, {})
    }),

    -- cite
    postfix(".cite", {
        f(function(_, parent)
            return '<cite class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></cite>'
        end, {})
    }),
    postfix("#cite", {
        f(function(_, parent)
            return '<cite id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></cite>'
        end, {})
    }),

    -- q (quotation)
    postfix(".q", {
        f(function(_, parent)
            return '<q class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></q>'
        end, {})
    }),
    postfix("#q", {
        f(function(_, parent)
            return '<q id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></q>'
        end, {})
    }),

    -- dfn (definition)
    postfix(".dfn", {
        f(function(_, parent)
            return '<dfn class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></dfn>'
        end, {})
    }),
    postfix("#dfn", {
        f(function(_, parent)
            return '<dfn id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></dfn>'
        end, {})
    }),

    -- samp (sample)
    postfix(".samp", {
        f(function(_, parent)
            return '<samp class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></samp>'
        end, {})
    }),
    postfix("#samp", {
        f(function(_, parent)
            return '<samp id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></samp>'
        end, {})
    }),

    -- kbd (keyboard)
    postfix(".kbd", {
        f(function(_, parent)
            return '<kbd class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></kbd>'
        end, {})
    }),
    postfix("#kbd", {
        f(function(_, parent)
            return '<kbd id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></kbd>'
        end, {})
    }),

    -- var
    postfix(".var", {
        f(function(_, parent)
            return '<var class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></var>'
        end, {})
    }),
    postfix("#var", {
        f(function(_, parent)
            return '<var id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></var>'
        end, {})
    }),

    -- progress
    postfix(".progress", {
        f(function(_, parent)
            return '<progress class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></progress>'
        end, {})
    }),
    postfix("#progress", {
        f(function(_, parent)
            return '<progress id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></progress>'
        end, {})
    }),

    -- meter
    postfix(".meter", {
        f(function(_, parent)
            return '<meter class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></meter>'
        end, {})
    }),
    postfix("#meter", {
        f(function(_, parent)
            return '<meter id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></meter>'
        end, {})
    }),

    -- audio
    postfix(".audio", {
        f(function(_, parent)
            return '<audio class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></audio>'
        end, {})
    }),
    postfix("#audio", {
        f(function(_, parent)
            return '<audio id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></audio>'
        end, {})
    }),

    -- video
    postfix(".video", {
        f(function(_, parent)
            return '<video class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></video>'
        end, {})
    }),
    postfix("#video", {
        f(function(_, parent)
            return '<video id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></video>'
        end, {})
    }),

    -- source
    postfix(".source", {
        f(function(_, parent)
            return '<source class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#source", {
        f(function(_, parent)
            return '<source id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- track
    postfix(".track", {
        f(function(_, parent)
            return '<track class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#track", {
        f(function(_, parent)
            return '<track id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- canvas
    postfix(".canvas", {
        f(function(_, parent)
            return '<canvas class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></canvas>'
        end, {})
    }),
    postfix("#canvas", {
        f(function(_, parent)
            return '<canvas id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></canvas>'
        end, {})
    }),

    -- svg
    postfix(".svg", {
        f(function(_, parent)
            return '<svg class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></svg>'
        end, {})
    }),
    postfix("#svg", {
        f(function(_, parent)
            return '<svg id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></svg>'
        end, {})
    }),

    -- map
    postfix(".map", {
        f(function(_, parent)
            return '<map class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></map>'
        end, {})
    }),
    postfix("#map", {
        f(function(_, parent)
            return '<map id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></map>'
        end, {})
    }),

    -- area
    postfix(".area", {
        f(function(_, parent)
            return '<area class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#area", {
        f(function(_, parent)
            return '<area id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- object
    postfix(".object", {
        f(function(_, parent)
            return '<object class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></object>'
        end, {})
    }),
    postfix("#object", {
        f(function(_, parent)
            return '<object id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></object>'
        end, {})
    }),

    -- param
    postfix(".param", {
        f(function(_, parent)
            return '<param class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#param", {
        f(function(_, parent)
            return '<param id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- embed
    postfix(".embed", {
        f(function(_, parent)
            return '<embed class="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),
    postfix("#embed", {
        f(function(_, parent)
            return '<embed id="' .. parent.snippet.env.POSTFIX_MATCH .. '">'
        end, {})
    }),

    -- template
    postfix(".template", {
        f(function(_, parent)
            return '<template class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></template>'
        end, {})
    }),
    postfix("#template", {
        f(function(_, parent)
            return '<template id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></template>'
        end, {})
    }),

    -- slot
    postfix(".slot", {
        f(function(_, parent)
            return '<slot class="' .. parent.snippet.env.POSTFIX_MATCH .. '"></slot>'
        end, {})
    }),
    postfix("#slot", {
        f(function(_, parent)
            return '<slot id="' .. parent.snippet.env.POSTFIX_MATCH .. '"></slot>'
        end, {})
    }),
}
