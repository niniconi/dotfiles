local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    ---------------------------------------
    -- 1. Selectors & Structure
    ---------------------------------------

    s({ trig = '*', dscr = 'Universal selector' },
        t('*')
    ),

    s({ trig = 'tag', dscr = 'Element selector' },
        fmt([[
{} {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = 'cls', dscr = 'Class selector' },
        fmt([[
.{} {{
    {}
}}
]],
            {
                i(1, 'class'),
                i(0),
            }
        )
    ),

    s({ trig = 'id', dscr = 'ID selector' },
        fmt([[
#{} {{
    {}
}}
]],
            {
                i(1, 'id'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr', dscr = 'Attribute selector' },
        fmt([[
[{}] {{
    {}
}}
]],
            {
                i(1, 'attribute'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr=', dscr = 'Attribute equals selector' },
        fmt([[
[{}="{}"] {{
    {}
}}
]],
            {
                i(1, 'attr'),
                i(2, 'value'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr~=', dscr = 'Attribute contains selector' },
        fmt([[
[{}~="{}"] {{
    {}
}}
]],
            {
                i(1, 'attr'),
                i(2, 'value'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr|=', dscr = 'Attribute starts with selector' },
        fmt([[
[{}|="{}"] {{
    {}
}}
]],
            {
                i(1, 'attr'),
                i(2, 'value'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr^=', dscr = 'Attribute prefix selector' },
        fmt([[
[{}^="{}"] {{
    {}
}}
]],
            {
                i(1, 'attr'),
                i(2, 'value'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr$=', dscr = 'Attribute suffix selector' },
        fmt([[
[{}$="{}"] {{
    {}
}}
]],
            {
                i(1, 'attr'),
                i(2, 'value'),
                i(0),
            }
        )
    ),

    s({ trig = 'attr*=', dscr = 'Attribute substring selector' },
        fmt([[
[{}*="{}"] {{
    {}
}}
]],
            {
                i(1, 'attr'),
                i(2, 'value'),
                i(0),
            }
        )
    ),

    s({ trig = 'desc', dscr = 'Descendant selector' },
        fmt([[
{} {} {{
    {}
}}
]],
            {
                i(1, 'parent'),
                i(2, 'child'),
                i(0),
            }
        )
    ),

    s({ trig = 'child', dscr = 'Direct child selector' },
        fmt([[
{} > {} {{
    {}
}}
]],
            {
                i(1, 'parent'),
                i(2, 'child'),
                i(0),
            }
        )
    ),

    s({ trig = '+', dscr = 'Adjacent sibling selector' },
        fmt([[
{} + {} {{
    {}
}}
]],
            {
                i(1, 'element1'),
                i(2, 'element2'),
                i(0),
            }
        )
    ),

    s({ trig = '~', dscr = 'General sibling selector' },
        fmt([[
{} ~ {} {{
    {}
}}
]],
            {
                i(1, 'element1'),
                i(2, 'element2'),
                i(0),
            }
        )
    ),

    s({ trig = 'group', dscr = 'Selector grouping' },
        fmt([[
{}, {} {{
    {}
}}
]],
            {
                i(1, 'selector1'),
                i(2, 'selector2'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 2. Pseudo-classes
    ---------------------------------------

    s({ trig = ':hover', dscr = 'Hover pseudo-class' },
        fmt([[
{}:hover {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':focus', dscr = 'Focus pseudo-class' },
        fmt([[
{}:focus {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':active', dscr = 'Active pseudo-class' },
        fmt([[
{}:active {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':visited', dscr = 'Visited pseudo-class' },
        fmt([[
{}:visited {{
    {}
}}
]],
            {
                i(1, 'a'),
                i(0),
            }
        )
    ),

    s({ trig = ':link', dscr = 'Link pseudo-class' },
        fmt([[
{}:link {{
    {}
}}
]],
            {
                i(1, 'a'),
                i(0),
            }
        )
    ),

    s({ trig = ':first-child', dscr = 'First child pseudo-class' },
        fmt([[
{}:first-child {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':last-child', dscr = 'Last child pseudo-class' },
        fmt([[
{}:last-child {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':nth-child', dscr = 'Nth child pseudo-class' },
        fmt([[
{}:nth-child({}) {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(2, 'n'),
                i(0),
            }
        )
    ),

    s({ trig = ':nth-last-child', dscr = 'Nth last child pseudo-class' },
        fmt([[
{}:nth-last-child({}) {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(2, 'n'),
                i(0),
            }
        )
    ),

    s({ trig = ':only-child', dscr = 'Only child pseudo-class' },
        fmt([[
{}:only-child {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':first-of-type', dscr = 'First of type pseudo-class' },
        fmt([[
{}:first-of-type {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':last-of-type', dscr = 'Last of type pseudo-class' },
        fmt([[
{}:last-of-type {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = ':nth-of-type', dscr = 'Nth of type pseudo-class' },
        fmt([[
{}:nth-of-type({}) {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(2, 'n'),
                i(0),
            }
        )
    ),

    s({ trig = ':not', dscr = 'Not pseudo-class' },
        fmt([[
{}:not({}) {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(2, 'selector'),
                i(0),
            }
        )
    ),

    s({ trig = ':checked', dscr = 'Checked pseudo-class' },
        fmt([[
{}:checked {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':disabled', dscr = 'Disabled pseudo-class' },
        fmt([[
{}:disabled {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':enabled', dscr = 'Enabled pseudo-class' },
        fmt([[
{}:enabled {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':required', dscr = 'Required pseudo-class' },
        fmt([[
{}:required {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':optional', dscr = 'Optional pseudo-class' },
        fmt([[
{}:optional {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':valid', dscr = 'Valid pseudo-class' },
        fmt([[
{}:valid {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':invalid', dscr = 'Invalid pseudo-class' },
        fmt([[
{}:invalid {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    s({ trig = ':root', dscr = 'Root pseudo-class' },
        fmt([[
:root {{
    {}
}}
]],
            {
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 3. Pseudo-elements
    ---------------------------------------

    s({ trig = '::before', dscr = 'Before pseudo-element' },
        fmt([[
{}::before {{
    content: "{}";
    {}
}}
]],
            {
                i(1, 'element'),
                i(2, ''),
                i(0),
            }
        )
    ),

    s({ trig = '::after', dscr = 'After pseudo-element' },
        fmt([[
{}::after {{
    content: "{}";
    {}
}}
]],
            {
                i(1, 'element'),
                i(2, ''),
                i(0),
            }
        )
    ),

    s({ trig = '::first-letter', dscr = 'First letter pseudo-element' },
        fmt([[
{}::first-letter {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = '::first-line', dscr = 'First line pseudo-element' },
        fmt([[
{}::first-line {{
    {}
}}
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = '::selection', dscr = 'Selection pseudo-element' },
        fmt([[
::selection {{
    {}
}}
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = '::placeholder', dscr = 'Placeholder pseudo-element' },
        fmt([[
{}::placeholder {{
    {}
}}
]],
            {
                i(1, 'input'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 4. Box Model
    ---------------------------------------

    s({ trig = 'margin', dscr = 'Margin property' },
        fmt([[
margin: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'margin-top', dscr = 'Margin top' },
        fmt([[
margin-top: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'margin-right', dscr = 'Margin right' },
        fmt([[
margin-right: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'margin-bottom', dscr = 'Margin bottom' },
        fmt([[
margin-bottom: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'margin-left', dscr = 'Margin left' },
        fmt([[
margin-left: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'padding', dscr = 'Padding property' },
        fmt([[
padding: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'padding-top', dscr = 'Padding top' },
        fmt([[
padding-top: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'padding-right', dscr = 'Padding right' },
        fmt([[
padding-right: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'padding-bottom', dscr = 'Padding bottom' },
        fmt([[
padding-bottom: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'padding-left', dscr = 'Padding left' },
        fmt([[
padding-left: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'width', dscr = 'Width property' },
        fmt([[
width: {};
]],
            {
                i(0, '100px'),
            }
        )
    ),

    s({ trig = 'height', dscr = 'Height property' },
        fmt([[
height: {};
]],
            {
                i(0, '100px'),
            }
        )
    ),

    s({ trig = 'max-width', dscr = 'Max width property' },
        fmt([[
max-width: {};
]],
            {
                i(0, '100%'),
            }
        )
    ),

    s({ trig = 'max-height', dscr = 'Max height property' },
        fmt([[
max-height: {};
]],
            {
                i(0, '100%'),
            }
        )
    ),

    s({ trig = 'min-width', dscr = 'Min width property' },
        fmt([[
min-width: {};
]],
            {
                i(0, '100px'),
            }
        )
    ),

    s({ trig = 'min-height', dscr = 'Min height property' },
        fmt([[
min-height: {};
]],
            {
                i(0, '100px'),
            }
        )
    ),

    s({ trig = 'box-sizing', dscr = 'Box sizing property' },
        fmt([[
box-sizing: {};
]],
            {
                c(1, { t('border-box'), t('content-box'), t('padding-box') }),
            }
        )
    ),

    s({ trig = 'display', dscr = 'Display property' },
        fmt([[
display: {};
]],
            {
                c(1, { t('block'), t('inline'), t('inline-block'), t('flex'), t('inline-flex'), t('grid'), t('inline-grid'), t('none'), t('table'), t('table-cell'), t('flow'), t('contents') }),
            }
        )
    ),

    s({ trig = 'overflow', dscr = 'Overflow property' },
        fmt([[
overflow: {};
]],
            {
                c(1, { t('auto'), t('hidden'), t('scroll'), t('visible') }),
            }
        )
    ),

    ---------------------------------------
    -- 5. Layout (Flexbox & Grid)
    ---------------------------------------

    s({ trig = 'flex', dscr = 'Flex container' },
        fmt([[
display: flex;
flex-direction: {};
justify-content: {};
align-items: {};
]],
            {
                c(1, { t('row'), t('row-reverse'), t('column'), t('column-reverse') }),
                c(2, { t('flex-start'), t('flex-end'), t('center'), t('space-between'), t('space-around'), t('space-evenly') }),
                c(3, { t('stretch'), t('flex-start'), t('flex-end'), t('center'), t('baseline') }),
            }
        )
    ),

    s({ trig = 'flex-wrap', dscr = 'Flex wrap' },
        fmt([[
flex-wrap: {};
]],
            {
                c(1, { t('nowrap'), t('wrap'), t('wrap-reverse') }),
            }
        )
    ),

    s({ trig = 'flex-grow', dscr = 'Flex grow' },
        fmt([[
flex-grow: {};
]],
            {
                i(0, '1'),
            }
        )
    ),

    s({ trig = 'flex-shrink', dscr = 'Flex shrink' },
        fmt([[
flex-shrink: {};
]],
            {
                i(0, '1'),
            }
        )
    ),

    s({ trig = 'flex-basis', dscr = 'Flex basis' },
        fmt([[
flex-basis: {};
]],
            {
                i(0, 'auto'),
            }
        )
    ),

    s({ trig = 'flex-flow', dscr = 'Flex flow shorthand' },
        fmt([[
flex-flow: {} {};
]],
            {
                c(1, { t('row'), t('row-reverse'), t('column'), t('column-reverse'), t('nowrap'), t('wrap'), t('wrap-reverse') }),
                i(0),
            }
        )
    ),

    s({ trig = 'justify-content', dscr = 'Justify content' },
        fmt([[
justify-content: {};
]],
            {
                c(1, { t('flex-start'), t('flex-end'), t('center'), t('space-between'), t('space-around'), t('space-evenly'), t('start'), t('end'), t('left'), t('right') }),
            }
        )
    ),

    s({ trig = 'align-items', dscr = 'Align items' },
        fmt([[
align-items: {};
]],
            {
                c(1, { t('stretch'), t('flex-start'), t('flex-end'), t('center'), t('baseline'), t('start'), t('end'), t('self-start'), t('self-end') }),
            }
        )
    ),

    s({ trig = 'align-content', dscr = 'Align content' },
        fmt([[
align-content: {};
]],
            {
                c(1, { t('flex-start'), t('flex-end'), t('center'), t('space-between'), t('space-around'), t('space-evenly'), t('stretch'), t('start'), t('end') }),
            }
        )
    ),

    s({ trig = 'align-self', dscr = 'Align self' },
        fmt([[
align-self: {};
]],
            {
                c(1, { t('auto'), t('flex-start'), t('flex-end'), t('center'), t('baseline'), t('stretch'), t('start'), t('end') }),
            }
        )
    ),

    s({ trig = 'order', dscr = 'Flex order' },
        fmt([[
order: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'grid', dscr = 'Grid container' },
        fmt([[
display: grid;
grid-template-columns: {};
grid-template-rows: {};
gap: {};
]],
            {
                i(1, 'repeat(3, 1fr)'),
                i(2, 'auto'),
                i(0, '10px'),
            }
        )
    ),

    s({ trig = 'grid-template-columns', dscr = 'Grid template columns' },
        fmt([[
grid-template-columns: {};
]],
            {
                i(0, 'repeat(3, 1fr)'),
            }
        )
    ),

    s({ trig = 'grid-template-rows', dscr = 'Grid template rows' },
        fmt([[
grid-template-rows: {};
]],
            {
                i(0, 'auto'),
            }
        )
    ),

    s({ trig = 'grid-column', dscr = 'Grid column' },
        fmt([[
grid-column: {};
]],
            {
                i(0, 'span 2'),
            }
        )
    ),

    s({ trig = 'grid-row', dscr = 'Grid row' },
        fmt([[
grid-row: {};
]],
            {
                i(0, 'span 2'),
            }
        )
    ),

    s({ trig = 'grid-area', dscr = 'Grid area' },
        fmt([[
grid-area: {};
]],
            {
                i(0, '1 / 2 / 3 / 4'),
            }
        )
    ),

    s({ trig = 'gap', dscr = 'Gap property' },
        fmt([[
gap: {};
]],
            {
                i(0, '10px'),
            }
        )
    ),

    s({ trig = 'column-gap', dscr = 'Column gap' },
        fmt([[
column-gap: {};
]],
            {
                i(0, '10px'),
            }
        )
    ),

    s({ trig = 'row-gap', dscr = 'Row gap' },
        fmt([[
row-gap: {};
]],
            {
                i(0, '10px'),
            }
        )
    ),

    ---------------------------------------
    -- 6. Typography
    ---------------------------------------

    s({ trig = 'font-family', dscr = 'Font family' },
        fmt([[
font-family: {};
]],
            {
                i(0, 'Arial, sans-serif'),
            }
        )
    ),

    s({ trig = 'font-size', dscr = 'Font size' },
        fmt([[
font-size: {};
]],
            {
                i(0, '16px'),
            }
        )
    ),

    s({ trig = 'font-weight', dscr = 'Font weight' },
        fmt([[
font-weight: {};
]],
            {
                c(1, { t('normal'), t('bold'), t('100'), t('200'), t('300'), t('400'), t('500'), t('600'), t('700'), t('800'), t('900') }),
            }
        )
    ),

    s({ trig = 'font-style', dscr = 'Font style' },
        fmt([[
font-style: {};
]],
            {
                c(1, { t('normal'), t('italic'), t('oblique') }),
            }
        )
    ),

    s({ trig = 'font-variant', dscr = 'Font variant' },
        fmt([[
font-variant: {};
]],
            {
                c(1, { t('normal'), t('small-caps'), t('all-small-caps'), t('petite-caps'), t('unicase'), t('titling-caps') }),
            }
        )
    ),

    s({ trig = 'line-height', dscr = 'Line height' },
        fmt([[
line-height: {};
]],
            {
                i(0, '1.5'),
            }
        )
    ),

    s({ trig = 'letter-spacing', dscr = 'Letter spacing' },
        fmt([[
letter-spacing: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'word-spacing', dscr = 'Word spacing' },
        fmt([[
word-spacing: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'text-align', dscr = 'Text align' },
        fmt([[
text-align: {};
]],
            {
                c(1, { t('left'), t('right'), t('center'), t('justify'), t('justify-all'), t('start'), t('end') }),
            }
        )
    ),

    s({ trig = 'text-decoration', dscr = 'Text decoration' },
        fmt([[
text-decoration: {};
]],
            {
                c(1, { t('none'), t('underline'), t('overline'), t('line-through'), t('blink') }),
            }
        )
    ),

    s({ trig = 'text-transform', dscr = 'Text transform' },
        fmt([[
text-transform: {};
]],
            {
                c(1, { t('none'), t('capitalize'), t('uppercase'), t('lowercase'), t('full-width') }),
            }
        )
    ),

    s({ trig = 'text-indent', dscr = 'Text indent' },
        fmt([[
text-indent: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'vertical-align', dscr = 'Vertical align' },
        fmt([[
vertical-align: {};
]],
            {
                c(1, { t('baseline'), t('sub'), t('super'), t('top'), t('text-top'), t('middle'), t('bottom'), t('text-bottom') }),
            }
        )
    ),

    s({ trig = 'color', dscr = 'Color property' },
        fmt([[
color: {};
]],
            {
                i(0, '#000'),
            }
        )
    ),

    s({ trig = 'text-shadow', dscr = 'Text shadow' },
        fmt([[
text-shadow: {}px {}px {}px {};
]],
            {
                i(1, '1'),
                i(2, '1'),
                i(3, '2'),
                i(0, 'rgba(0,0,0,0.5)'),
            }
        )
    ),

    s({ trig = 'white-space', dscr = 'White space' },
        fmt([[
white-space: {};
]],
            {
                c(1, { t('normal'), t('nowrap'), t('pre'), t('pre-line'), t('pre-wrap'), t('break-spaces') }),
            }
        )
    ),

    s({ trig = 'word-wrap', dscr = 'Word wrap' },
        fmt([[
word-wrap: {};
]],
            {
                c(1, { t('normal'), t('break-word'), t('break-all'), t('keep-all') }),
            }
        )
    ),

    s({ trig = 'overflow-wrap', dscr = 'Overflow wrap' },
        fmt([[
overflow-wrap: {};
]],
            {
                c(1, { t('normal'), t('break-word'), t('anywhere') }),
            }
        )
    ),

    ---------------------------------------
    -- 7. Background & Borders
    ---------------------------------------

    s({ trig = 'background', dscr = 'Background property' },
        fmt([[
background: {};
]],
            {
                i(0, '#fff'),
            }
        )
    ),

    s({ trig = 'background-color', dscr = 'Background color' },
        fmt([[
background-color: {};
]],
            {
                i(0, '#fff'),
            }
        )
    ),

    s({ trig = 'background-image', dscr = 'Background image' },
        fmt([[
background-image: url("{}");
]],
            {
                i(0, 'image.jpg'),
            }
        )
    ),

    s({ trig = 'background-position', dscr = 'Background position' },
        fmt([[
background-position: {} {};
]],
            {
                c(1, { t('left'), t('center'), t('right'), t('top'), t('bottom') }),
                i(0, 'center'),
            }
        )
    ),

    s({ trig = 'background-size', dscr = 'Background size' },
        fmt([[
background-size: {};
]],
            {
                c(1, { t('auto'), t('cover'), t('contain'), t('100% 100%') }),
            }
        )
    ),

    s({ trig = 'background-repeat', dscr = 'Background repeat' },
        fmt([[
background-repeat: {};
]],
            {
                c(1, { t('repeat'), t('repeat-x'), t('repeat-y'), t('no-repeat'), t('space'), t('round') }),
            }
        )
    ),

    s({ trig = 'background-attachment', dscr = 'Background attachment' },
        fmt([[
background-attachment: {};
]],
            {
                c(1, { t('scroll'), t('fixed'), t('local') }),
            }
        )
    ),

    s({ trig = 'border', dscr = 'Border property' },
        fmt([[
border: {}px {} {};
]],
            {
                i(1, '1'),
                c(2, { t('solid'), t('dashed'), t('dotted'), t('double'), t('groove'), t('ridge'), t('inset'), t('outset'), t('none') }),
                i(0, '#000'),
            }
        )
    ),

    s({ trig = 'border-width', dscr = 'Border width' },
        fmt([[
border-width: {};
]],
            {
                i(0, '1px'),
            }
        )
    ),

    s({ trig = 'border-style', dscr = 'Border style' },
        fmt([[
border-style: {};
]],
            {
                c(1, { t('none'), t('solid'), t('dashed'), t('dotted'), t('double'), t('groove'), t('ridge'), t('inset'), t('outset'), t('hidden') }),
            }
        )
    ),

    s({ trig = 'border-color', dscr = 'Border color' },
        fmt([[
border-color: {};
]],
            {
                i(0, '#000'),
            }
        )
    ),

    s({ trig = 'border-radius', dscr = 'Border radius' },
        fmt([[
border-radius: {};
]],
            {
                i(0, '5px'),
            }
        )
    ),

    s({ trig = 'box-shadow', dscr = 'Box shadow' },
        fmt([[
box-shadow: {}px {}px {}px {}px {};
]],
            {
                i(1, '0'),
                i(2, '2'),
                i(3, '4'),
                i(4, '0'),
                i(0, 'rgba(0,0,0,0.1)'),
            }
        )
    ),

    s({ trig = 'border-image', dscr = 'Border image' },
        fmt([[
border-image: {};
]],
            {
                i(0, 'url(border.png) 30 stretch'),
            }
        )
    ),

    ---------------------------------------
    -- 8. Positioning
    ---------------------------------------

    s({ trig = 'position', dscr = 'Position property' },
        fmt([[
position: {};
]],
            {
                c(1, { t('static'), t('relative'), t('absolute'), t('fixed'), t('sticky') }),
            }
        )
    ),

    s({ trig = 'top', dscr = 'Top property' },
        fmt([[
top: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'right', dscr = 'Right property' },
        fmt([[
right: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'bottom', dscr = 'Bottom property' },
        fmt([[
bottom: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'left', dscr = 'Left property' },
        fmt([[
left: {};
]],
            {
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'z-index', dscr = 'Z index' },
        fmt([[
z-index: {};
]],
            {
                i(0, '1'),
            }
        )
    ),

    s({ trig = 'float', dscr = 'Float property' },
        fmt([[
float: {};
]],
            {
                c(1, { t('none'), t('left'), t('right') }),
            }
        )
    ),

    s({ trig = 'clear', dscr = 'Clear property' },
        fmt([[
clear: {};
]],
            {
                c(1, { t('none'), t('left'), t('right'), t('both') }),
            }
        )
    ),

    ---------------------------------------
    -- 9. Transitions & Animations
    ---------------------------------------

    s({ trig = 'transition', dscr = 'Transition property' },
        fmt([[
transition: {} {} {};
]],
            {
                i(1, 'all'),
                i(2, '0.3s'),
                i(0, 'ease'),
            }
        )
    ),

    s({ trig = 'transition-property', dscr = 'Transition property' },
        fmt([[
transition-property: {};
]],
            {
                i(0, 'all'),
            }
        )
    ),

    s({ trig = 'transition-duration', dscr = 'Transition duration' },
        fmt([[
transition-duration: {};
]],
            {
                i(0, '0.3s'),
            }
        )
    ),

    s({ trig = 'transition-timing-function', dscr = 'Transition timing function' },
        fmt([[
transition-timing-function: {};
]],
            {
                c(1, { t('ease'), t('linear'), t('ease-in'), t('ease-out'), t('ease-in-out'), t('step-start'), t('step-end'), t('steps()'), t('cubic-bezier()') }),
            }
        )
    ),

    s({ trig = 'transition-delay', dscr = 'Transition delay' },
        fmt([[
transition-delay: {};
]],
            {
                i(0, '0s'),
            }
        )
    ),

    s({ trig = 'animation', dscr = 'Animation property' },
        fmt([[
animation: {} {} {} {} {};
]],
            {
                i(1, 'name'),
                i(2, 'duration'),
                i(3, 'timing-function'),
                i(4, 'delay'),
                i(0, 'iteration-count'),
            }
        )
    ),

    s({ trig = 'keyframes', dscr = 'Keyframes rule' },
        fmt([[
@keyframes {} {{
    0% {{ {} }}
    100% {{ {} }}
}}
]],
            {
                i(1, 'name'),
                i(2, 'from'),
                i(0, 'to'),
            }
        )
    ),

    s({ trig = 'transform', dscr = 'Transform property' },
        fmt([[
transform: {};
]],
            {
                c(1, { t('none'), t('rotate()'), t('scale()'), t('scaleX()'), t('scaleY()'), t('translate()'), t('translateX()'), t('translateY()'), t('skew()'), t('matrix()') }),
            }
        )
    ),

    ---------------------------------------
    -- 10. Media Queries
    ---------------------------------------

    s({ trig = '@media', dscr = 'Media query' },
        fmt([[
@media {} {{
    {}
}}
]],
            {
                c(1, { t('screen'), t('print'), t('speech'), t('all'), t('(min-width: 768px)'), t('(max-width: 1024px)'), t('(min-width: 768px) and (max-width: 1024px)') }),
                i(0),
            }
        )
    ),

    s({ trig = '@media-screen', dscr = 'Media query (screen)' },
        fmt([[
@media screen and (min-width: {}px) {{
    {}
}}
]],
            {
                i(1, '768'),
                i(0),
            }
        )
    ),

    s({ trig = '@media-print', dscr = 'Media query (print)' },
        fmt([[
@media print {{
    {}
}}
]],
            {
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 11. Variables & Custom Properties
    ---------------------------------------

    s({ trig = '--', dscr = 'CSS custom property' },
        fmt([[
--{}: {};
]],
            {
                i(1, 'name'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = ':root', dscr = 'Root variables' },
        fmt([[
:root {{
    --{}: {};
    {}
}}
]],
            {
                i(1, 'primary-color'),
                i(2, '#007bff'),
                i(0),
            }
        )
    ),

    s({ trig = 'var', dscr = 'Var function' },
        fmt([[
var(--{})
]],
            {
                i(0, 'name'),
            }
        )
    ),

    s({ trig = 'calc', dscr = 'Calc function' },
        fmt([[
calc({})
]],
            {
                i(0, '100% - 20px'),
            }
        )
    ),

    ---------------------------------------
    -- 12. Other Properties
    ---------------------------------------

    s({ trig = 'opacity', dscr = 'Opacity property' },
        fmt([[
opacity: {};
]],
            {
                i(0, '1'),
            }
        )
    ),

    s({ trig = 'visibility', dscr = 'Visibility property' },
        fmt([[
visibility: {};
]],
            {
                c(1, { t('visible'), t('hidden'), t('collapse') }),
            }
        )
    ),

    s({ trig = 'cursor', dscr = 'Cursor property' },
        fmt([[
cursor: {};
]],
            {
                c(1, { t('auto'), t('default'), t('pointer'), t('move'), t('text'), t('wait'), t('help'), t('crosshair'), t('not-allowed'), t('grab'), t('grabbing') }),
            }
        )
    ),

    s({ trig = 'outline', dscr = 'Outline property' },
        fmt([[
outline: {}px {} {};
]],
            {
                i(1, '1'),
                c(2, { t('solid'), t('dashed'), t('dotted') }),
                i(0, '#000'),
            }
        )
    ),

    s({ trig = 'resize', dscr = 'Resize property' },
        fmt([[
resize: {};
]],
            {
                c(1, { t('none'), t('both'), t('horizontal'), t('vertical'), t('block'), t('inline') }),
            }
        )
    ),

    s({ trig = 'user-select', dscr = 'User select' },
        fmt([[
user-select: {};
]],
            {
                c(1, { t('auto'), t('none'), t('text'), t('all') }),
            }
        )
    ),

    s({ trig = 'pointer-events', dscr = 'Pointer events' },
        fmt([[
pointer-events: {};
]],
            {
                c(1, { t('auto'), t('none'), t('visiblePainted'), t('visibleFill'), t('visibleStroke'), t('painted'), t('fill'), t('stroke'), t('all') }),
            }
        )
    ),

    s({ trig = 'list-style', dscr = 'List style' },
        fmt([[
list-style: {} {} {};
]],
            {
                c(1, { t('none'), t('disc'), t('circle'), t('square'), t('decimal'), t('decimal-leading-zero'), t('lower-roman'), t('upper-roman'), t('lower-greek'), t('lower-alpha'), t('upper-alpha'), t('armenian'), t('georgian') }),
                c(2, { t('inside'), t('outside') }),
                i(0, 'url()'),
            }
        )
    ),

    s({ trig = 'counter-reset', dscr = 'Counter reset' },
        fmt([[
counter-reset: {};
]],
            {
                i(0, 'section'),
            }
        )
    ),

    s({ trig = 'counter-increment', dscr = 'Counter increment' },
        fmt([[
counter-increment: {};
]],
            {
                i(0, 'section'),
            }
        )
    ),

    s({ trig = 'content', dscr = 'Content property' },
        fmt([[
content: "{}";
]],
            {
                i(0, ''),
            }
        )
    ),

    s({ trig = 'quotes', dscr = 'Quotes property' },
        fmt([[
quotes: "{}" "{}";
]],
            {
                i(1, '"'),
                i(0, '"'),
            }
        )
    ),

    s({ trig = 'text-overflow', dscr = 'Text overflow' },
        fmt([[
text-overflow: {};
]],
            {
                c(1, { t('clip'), t('ellipsis'), t('string') }),
            }
        )
    ),

    s({ trig = 'object-fit', dscr = 'Object fit' },
        fmt([[
object-fit: {};
]],
            {
                c(1, { t('fill'), t('contain'), t('cover'), t('none'), t('scale-down') }),
            }
        )
    ),

    s({ trig = 'object-position', dscr = 'Object position' },
        fmt([[
object-position: {} {};
]],
            {
                i(1, '50%'),
                i(0, '50%'),
            }
        )
    ),
}
