local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
    ---------------------------------------
    -- 1. Basic
    ---------------------------------------

    s({ trig = 'log', dscr = 'Console log' },
        fmt([[
console.log({});
]],
            {
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'warn', dscr = 'Console warn' },
        fmt([[
console.warn({});
]],
            {
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'error', dscr = 'Console error' },
        fmt([[
console.error({});
]],
            {
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'info', dscr = 'Console info' },
        fmt([[
console.info({});
]],
            {
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'table', dscr = 'Console table' },
        fmt([[
console.table({});
]],
            {
                i(0, 'data'),
            }
        )
    ),

    s({ trig = 'dir', dscr = 'Console dir' },
        fmt([[
console.dir({});
]],
            {
                i(0, 'object'),
            }
        )
    ),

    s({ trig = 'time', dscr = 'Console time' },
        fmt([[
console.time('{}');
{}
console.timeEnd('{}');
]],
            {
                i(1, 'timer'),
                i(2),
                i(1),
            }
        )
    ),

    s({ trig = 'trace', dscr = 'Console trace' },
        t('console.trace();')
    ),

    s({ trig = 'group', dscr = 'Console group' },
        fmt([[
console.group('{}');
{}
console.groupEnd();
]],
            {
                i(1, 'label'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 2. Variables
    ---------------------------------------

    s({ trig = 'const', dscr = 'Const declaration' },
        fmt([[
const {} = {};
]],
            {
                i(1, 'variable'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'let', dscr = 'Let declaration' },
        fmt([[
let {} = {};
]],
            {
                i(1, 'variable'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'var', dscr = 'Var declaration' },
        fmt([[
var {} = {};
]],
            {
                i(1, 'variable'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'destructure', dscr = 'Destructuring assignment' },
        fmt([[
const {{ {} }} = {};
]],
            {
                i(1, 'a, b'),
                i(0, 'object'),
            }
        )
    ),

    ---------------------------------------
    -- 3. Functions
    ---------------------------------------

    s({ trig = 'fn', dscr = 'Function declaration' },
        fmt([[
function {}({}) {{
    {}
}}
]],
            {
                i(1, 'name'),
                i(2, 'arg'),
                i(0, 'return'),
            }
        )
    ),

    s({ trig = 'afn', dscr = 'Arrow function' },
        fmt([[
({}) => {{
    {}
}}
]],
            {
                i(1, 'arg'),
                i(0, 'return'),
            }
        )
    ),

    s({ trig = 'afnret', dscr = 'Arrow function with return' },
        fmt([[
({}) => {},
]],
            {
                i(1, 'arg'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'iife', dscr = 'Immediately invoked function' },
        fmt([[
(function() {{
    {}
}})();
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'asyncfn', dscr = 'Async function' },
        fmt([[
async function {}({}) {{
    {}
}}
]],
            {
                i(1, 'name'),
                i(2, 'arg'),
                i(0, 'await'),
            }
        )
    ),

    s({ trig = 'asyncafn', dscr = 'Async arrow function' },
        fmt([[
async ({}) => {{
    {}
}}
]],
            {
                i(1, 'arg'),
                i(0, 'await'),
            }
        )
    ),

    s({ trig = 'callback', dscr = 'Callback function pattern' },
        fmt([[
function {}({}, callback) {{
    if (err) {{
        callback(err);
    }}
    callback(null, {});
}}
]],
            {
                i(1, 'name'),
                i(2, 'arg'),
                i(0, 'result'),
            }
        )
    ),

    s({ trig = 'promise', dscr = 'Promise pattern' },
        fmt([[
new Promise((resolve, reject) => {{
    {}
}})
]],
            {
                i(0, 'resolve()'),
            }
        )
    ),

    ---------------------------------------
    -- 4. Control Flow
    ---------------------------------------

    s({ trig = 'if', dscr = 'If statement' },
        fmt([[
if ({}) {{
    {}
}}
]],
            {
                i(1, 'condition'),
                i(0),
            }
        )
    ),

    s({ trig = 'ifelse', dscr = 'If else statement' },
        fmt([[
if ({}) {{
    {}
}} else {{
    {}
}}
]],
            {
                i(1, 'condition'),
                i(2),
                i(0),
            }
        )
    ),

    s({ trig = 'elseif', dscr = 'Else if statement' },
        fmt([[
else if ({}) {{
    {}
}}
]],
            {
                i(1, 'condition'),
                i(0),
            }
        )
    ),

    s({ trig = 'ternary', dscr = 'Ternary operator' },
        fmt([[
{} ? {} : {}
]],
            {
                i(1, 'condition'),
                i(2, 'true'),
                i(0, 'false'),
            }
        )
    ),

    s({ trig = 'switch', dscr = 'Switch statement' },
        fmt([[
switch ({}) {{
    case {}:
        {}
        break;
    default:
        {}
}}
]],
            {
                i(1, 'value'),
                i(2, 'case'),
                i(3),
                i(0),
            }
        )
    ),

    s({ trig = 'trycatch', dscr = 'Try catch' },
        fmt([[
try {{
    {}
}} catch ({}) {{
    {}
}}
]],
            {
                i(1),
                i(2, 'err'),
                i(0),
            }
        )
    ),

    s({ trig = 'trycatchfin', dscr = 'Try catch finally' },
        fmt([[
try {{
    {}
}} catch ({}) {{
    {}
}} finally {{
    {}
}}
]],
            {
                i(1),
                i(2, 'err'),
                i(3),
                i(0),
            }
        )
    ),

    s({ trig = 'throw', dscr = 'Throw error' },
        fmt([[
throw new Error({});
]],
            {
                i(0, '"error message"'),
            }
        )
    ),

    ---------------------------------------
    -- 5. Loops
    ---------------------------------------

    s({ trig = 'for', dscr = 'For loop' },
        fmt([[
for (let i = 0; i < {}.length; i++) {{
    const {} = {}[i];
    {}
}}
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(1),
                i(0),
            }
        )
    ),

    s({ trig = 'forof', dscr = 'For of loop' },
        fmt([[
for (const {} of {}) {{
    {}
}}
]],
            {
                i(1, 'item'),
                i(2, 'iterable'),
                i(0),
            }
        )
    ),

    s({ trig = 'forin', dscr = 'For in loop' },
        fmt([[
for (const {} in {}) {{
    {}
}}
]],
            {
                i(1, 'key'),
                i(2, 'object'),
                i(0),
            }
        )
    ),

    s({ trig = 'while', dscr = 'While loop' },
        fmt([[
while ({}) {{
    {}
}}
]],
            {
                i(1, 'condition'),
                i(0),
            }
        )
    ),

    s({ trig = 'dowhile', dscr = 'Do while loop' },
        fmt([[
do {{
    {}
}} while ({});
]],
            {
                i(1),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'foreach', dscr = 'ForEach method' },
        fmt([[
{}.forEach(({}) => {{
    {}
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 6. Arrays
    ---------------------------------------

    s({ trig = 'map', dscr = 'Map method' },
        fmt([[
{}.map(({}) => {{
    return {};
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'filter', dscr = 'Filter method' },
        fmt([[
{}.filter(({}) => {{
    return {};
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'reduce', dscr = 'Reduce method' },
        fmt([[
{}.reduce(({}, {}) => {{
    return {};
}}, {});
]],
            {
                i(1, 'array'),
                i(2, 'acc'),
                i(3, 'cur'),
                i(4, 'acc + cur'),
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'find', dscr = 'Find method' },
        fmt([[
{}.find(({}) => {{
    return {};
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'findIndex', dscr = 'FindIndex method' },
        fmt([[
{}.findIndex(({}) => {{
    return {};
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'some', dscr = 'Some method' },
        fmt([[
{}.some(({}) => {{
    return {};
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'every', dscr = 'Every method' },
        fmt([[
{}.every(({}) => {{
    return {};
}});
]],
            {
                i(1, 'array'),
                i(2, 'item'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'includes', dscr = 'Includes method' },
        fmt([[
{}.includes({});
]],
            {
                i(1, 'array'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'indexOf', dscr = 'IndexOf method' },
        fmt([[
{}.indexOf({});
]],
            {
                i(1, 'array'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'sort', dscr = 'Sort method' },
        fmt([[
{}.sort((a, b) => a - b);
]],
            {
                i(1, 'array'),
            }
        )
    ),

    s({ trig = 'reverse', dscr = 'Reverse method' },
        fmt([[
{}.reverse();
]],
            {
                i(1, 'array'),
            }
        )
    ),

    s({ trig = 'slice', dscr = 'Slice method' },
        fmt([[
{}.slice({}, {});
]],
            {
                i(1, 'array'),
                i(2, '0'),
                i(0, 'end'),
            }
        )
    ),

    s({ trig = 'splice', dscr = 'Splice method' },
        fmt([[
{}.splice({}, {}, {});
]],
            {
                i(1, 'array'),
                i(2, 'index'),
                i(3, 'deleteCount'),
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'concat', dscr = 'Concat method' },
        fmt([[
{}.concat({});
]],
            {
                i(1, 'array1'),
                i(0, 'array2'),
            }
        )
    ),

    s({ trig = 'join', dscr = 'Join method' },
        fmt([[
{}.join('{}');
]],
            {
                i(1, 'array'),
                i(0, ','),
            }
        )
    ),

    s({ trig = 'flat', dscr = 'Flat method' },
        fmt([[
{}.flat({});
]],
            {
                i(1, 'array'),
                i(0, '1'),
            }
        )
    ),

    s({ trig = 'fill', dscr = 'Fill method' },
        fmt([[
{}.fill({}, {}, {});
]],
            {
                i(1, 'array'),
                i(2, 'value'),
                i(3, '0'),
                i(0, 'length'),
            }
        )
    ),

    ---------------------------------------
    -- 7. Objects
    ---------------------------------------

    s({ trig = 'obj', dscr = 'Object literal' },
        fmt([[
{{
    {}: {},
}}
]],
            {
                i(1, 'key'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'keys', dscr = 'Object.keys' },
        fmt([[
Object.keys({});
]],
            {
                i(1, 'object'),
            }
        )
    ),

    s({ trig = 'values', dscr = 'Object.values' },
        fmt([[
Object.values({});
]],
            {
                i(1, 'object'),
            }
        )
    ),

    s({ trig = 'entries', dscr = 'Object.entries' },
        fmt([[
Object.entries({});
]],
            {
                i(1, 'object'),
            }
        )
    ),

    s({ trig = 'assign', dscr = 'Object.assign' },
        fmt([[
Object.assign({}, {});
]],
            {
                i(1, 'target'),
                i(0, 'source'),
            }
        )
    ),

    s({ trig = 'freeze', dscr = 'Object.freeze' },
        fmt([[
Object.freeze({});
]],
            {
                i(1, 'object'),
            }
        )
    ),

    s({ trig = 'create', dscr = 'Object.create' },
        fmt([[
Object.create({});
]],
            {
                i(1, 'null'),
            }
        )
    ),

    s({ trig = 'hasOwn', dscr = 'Object.hasOwn' },
        fmt([[
Object.hasOwn({}, '{}');
]],
            {
                i(1, 'object'),
                i(0, 'property'),
            }
        )
    ),

    ---------------------------------------
    -- 8. Classes
    ---------------------------------------

    s({ trig = 'class', dscr = 'Class declaration' },
        fmt([[
class {} {{
    constructor({}) {{
        {}
    }}
    {}
}}
]],
            {
                i(1, 'ClassName'),
                i(2, 'props'),
                i(3, 'this.props = props'),
                i(0),
            }
        )
    ),

    s({ trig = 'classExt', dscr = 'Class extends' },
        fmt([[
class {} extends {} {{
    constructor({}) {{
        super({});
        {}
    }}
}}
]],
            {
                i(1, 'ChildClass'),
                i(2, 'ParentClass'),
                i(3, 'props'),
                i(4, 'this.props = props'),
                i(0),
            }
        )
    ),

    s({ trig = 'method', dscr = 'Class method' },
        fmt([[
{}({}) {{
    {}
}}
]],
            {
                i(1, 'methodName'),
                i(2, 'arg'),
                i(0),
            }
        )
    ),

    s({ trig = 'get', dscr = 'Getter' },
        fmt([[
get {}() {{
    return {};
}}
]],
            {
                i(1, 'property'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'set', dscr = 'Setter' },
        fmt([[
set {}({}) {{
    this.{} = {};
}}
]],
            {
                i(1, 'property'),
                i(2, 'value'),
                i(3, '_property'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'static', dscr = 'Static method' },
        fmt([[
static {}({}) {{
    {}
}}
]],
            {
                i(1, 'methodName'),
                i(2, 'arg'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 9. DOM
    ---------------------------------------

    s({ trig = 'getById', dscr = 'Get element by ID' },
        fmt([[
document.getElementById('{}');
]],
            {
                i(0, 'id'),
            }
        )
    ),

    s({ trig = 'getByClass', dscr = 'Get elements by class' },
        fmt([[
document.getElementsByClassName('{}');
]],
            {
                i(0, 'class'),
            }
        )
    ),

    s({ trig = 'getByTag', dscr = 'Get elements by tag' },
        fmt([[
document.getElementsByTagName('{}');
]],
            {
                i(0, 'tag'),
            }
        )
    ),

    s({ trig = 'query', dscr = 'Query selector' },
        fmt([[
document.querySelector('{}');
]],
            {
                i(0, 'selector'),
            }
        )
    ),

    s({ trig = 'queryAll', dscr = 'Query selector all' },
        fmt([[
document.querySelectorAll('{}');
]],
            {
                i(0, 'selector'),
            }
        )
    ),

    s({ trig = 'createEl', dscr = 'Create element' },
        fmt([[
document.createElement('{}');
]],
            {
                i(0, 'div'),
            }
        )
    ),

    s({ trig = 'addEvt', dscr = 'Add event listener' },
        fmt([[
{}.addEventListener('{}', (e) => {{
    {}
}});
]],
            {
                i(1, 'element'),
                i(2, 'event'),
                i(0),
            }
        )
    ),

    s({ trig = 'removeEvt', dscr = 'Remove event listener' },
        fmt([[
{}.removeEventListener('{}', {});
]],
            {
                i(1, 'element'),
                i(2, 'event'),
                i(0, 'handler'),
            }
        )
    ),

    s({ trig = 'getAttr', dscr = 'Get attribute' },
        fmt([[
{}.getAttribute('{}');
]],
            {
                i(1, 'element'),
                i(0, 'attribute'),
            }
        )
    ),

    s({ trig = 'setAttr', dscr = 'Set attribute' },
        fmt([[
{}.setAttribute('{}', {});
]],
            {
                i(1, 'element'),
                i(2, 'attribute'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'removeAttr', dscr = 'Remove attribute' },
        fmt([[
{}.removeAttribute('{}');
]],
            {
                i(1, 'element'),
                i(0, 'attribute'),
            }
        )
    ),

    s({ trig = 'getVal', dscr = 'Get value (input)' },
        fmt([[
{}.value;
]],
            {
                i(1, 'element'),
            }
        )
    ),

    s({ trig = 'setVal', dscr = 'Set value (input)' },
        fmt([[
{}.value = {};
]],
            {
                i(1, 'element'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'getText', dscr = 'Get text content' },
        fmt([[
{}.textContent;
]],
            {
                i(1, 'element'),
            }
        )
    ),

    s({ trig = 'setText', dscr = 'Set text content' },
        fmt([[
{}.textContent = {};
]],
            {
                i(1, 'element'),
                i(0, 'text'),
            }
        )
    ),

    s({ trig = 'getHtml', dscr = 'Get innerHTML' },
        fmt([[
{}.innerHTML;
]],
            {
                i(1, 'element'),
            }
        )
    ),

    s({ trig = 'setHtml', dscr = 'Set innerHTML' },
        fmt([[
{}.innerHTML = {};
]],
            {
                i(1, 'element'),
                i(0, 'html'),
            }
        )
    ),

    s({ trig = 'addClass', dscr = 'Add class' },
        fmt([[
{}.classList.add('{}');
]],
            {
                i(1, 'element'),
                i(0, 'class'),
            }
        )
    ),

    s({ trig = 'removeClass', dscr = 'Remove class' },
        fmt([[
{}.classList.remove('{}');
]],
            {
                i(1, 'element'),
                i(0, 'class'),
            }
        )
    ),

    s({ trig = 'toggleClass', dscr = 'Toggle class' },
        fmt([[
{}.classList.toggle('{}');
]],
            {
                i(1, 'element'),
                i(0, 'class'),
            }
        )
    ),

    s({ trig = 'hasClass', dscr = 'Has class' },
        fmt([[
{}.classList.contains('{}');
]],
            {
                i(1, 'element'),
                i(0, 'class'),
            }
        )
    ),

    s({ trig = 'appendChild', dscr = 'Append child' },
        fmt([[
{}.appendChild({});
]],
            {
                i(1, 'parent'),
                i(0, 'child'),
            }
        )
    ),

    s({ trig = 'removeChild', dscr = 'Remove child' },
        fmt([[
{}.removeChild({});
]],
            {
                i(1, 'parent'),
                i(0, 'child'),
            }
        )
    ),

    s({ trig = 'replaceChild', dscr = 'Replace child' },
        fmt([[
{}.replaceChild({}, {});
]],
            {
                i(1, 'parent'),
                i(2, 'newChild'),
                i(0, 'oldChild'),
            }
        )
    ),

    s({ trig = 'insertBefore', dscr = 'Insert before' },
        fmt([[
{}.insertBefore({}, {});
]],
            {
                i(1, 'parent'),
                i(2, 'newNode'),
                i(0, 'referenceNode'),
            }
        )
    ),

    s({ trig = 'getStyle', dscr = 'Get computed style' },
        fmt([[
window.getComputedStyle({}).{};
]],
            {
                i(1, 'element'),
                i(0, 'property'),
            }
        )
    ),

    s({ trig = 'setStyle', dscr = 'Set style' },
        fmt([[
{}.style.{} = {};
]],
            {
                i(1, 'element'),
                i(2, 'property'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'setStyles', dscr = 'Set multiple styles' },
        fmt([[
Object.assign({}.style, {{
    {}: {},
}});
]],
            {
                i(1, 'element'),
                i(2, 'property'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'closest', dscr = 'Closest ancestor' },
        fmt([[
{}.closest('{}');
]],
            {
                i(1, 'element'),
                i(0, 'selector'),
            }
        )
    ),

    s({ trig = 'cloning', dscr = 'Clone node' },
        fmt([[
{}.cloneNode({});
]],
            {
                i(1, 'element'),
                c(2, { t('true'), t('false') }),
            }
        )
    ),

    ---------------------------------------
    -- 10. Events
    ---------------------------------------

    s({ trig = 'onclick', dscr = 'Click event' },
        fmt([[
{}.onclick = (e) => {{
    {}
}};
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = 'onchange', dscr = 'Change event' },
        fmt([[
{}.onchange = (e) => {{
    {}
}};
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = 'oninput', dscr = 'Input event' },
        fmt([[
{}.oninput = (e) => {{
    {}
}};
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = 'onsubmit', dscr = 'Submit event' },
        fmt([[
{}.onsubmit = (e) => {{
    {}
}};
]],
            {
                i(1, 'form'),
                i(0),
            }
        )
    ),

    s({ trig = 'onload', dscr = 'Load event' },
        fmt([[
window.onload = () => {{
    {}
}};
]],
            {
                i(0),
            }
        )
    ),

    s({ trig = 'onkeydown', dscr = 'Keydown event' },
        fmt([[
{}.onkeydown = (e) => {{
    {}
}};
]],
            {
                i(1, 'element'),
                i(0),
            }
        )
    ),

    s({ trig = 'preventDefault', dscr = 'Prevent default' },
        t('e.preventDefault();')
    ),

    s({ trig = 'stopProp', dscr = 'Stop propagation' },
        t('e.stopPropagation();')
    ),

    ---------------------------------------
    -- 11. Timing
    ---------------------------------------

    s({ trig = 'setTimeout', dscr = 'Set timeout' },
        fmt([[
setTimeout(() => {{
    {}
}}, {});
]],
            {
                i(1),
                i(0, '1000'),
            }
        )
    ),

    s({ trig = 'setInterval', dscr = 'Set interval' },
        fmt([[
setInterval(() => {{
    {}
}}, {});
]],
            {
                i(1),
                i(0, '1000'),
            }
        )
    ),

    s({ trig = 'debounce', dscr = 'Debounce function' },
        fmt([[
function debounce(func, wait) {{
    let timeout;
    return function(...args) {{
        const context = this;
        clearTimeout(timeout);
        timeout = setTimeout(() => {{
            func.apply(context, args);
        }}, wait);
    }};
}}
{}
]],
            {
                i(0),
            })
    ),
    s({ trig = 'throttle', dscr = 'Throttle function' },
        fmt([[
function throttle(func, limit) {{
    let lastFunc;
    let lastRan;
    return function(...args) {{
        const context = this;
        if (!lastRan) {{
            func.apply(context, args);
            lastRan = Date.now();
        }} else {{
            clearTimeout(lastFunc);
            lastFunc = setTimeout(function() {{
                if ((Date.now() - lastRan) >= limit) {{
                    func.apply(context, args);
                    lastRan = Date.now();
                }}
            }}, limit - (Date.now() - lastRan));
        }}
    }};
}}
{}
]],
            {
                i(0),
            })
    ),

    ---------------------------------------
    -- 12. JSON
    ---------------------------------------

    s({ trig = 'parse', dscr = 'JSON.parse' },
        fmt([[
JSON.parse({});
]],
            {
                i(1, 'string'),
            }
        )
    ),

    s({ trig = 'stringify', dscr = 'JSON.stringify' },
        fmt([[
JSON.stringify({}, null, {});
]],
            {
                i(1, 'obj'),
                i(0, '2'),
            }
        )
    ),

    ---------------------------------------
    -- 13. Storage
    ---------------------------------------

    s({ trig = 'localGet', dscr = 'LocalStorage getItem' },
        fmt([[
localStorage.getItem('{}');
]],
            {
                i(0, 'key'),
            }
        )
    ),

    s({ trig = 'localSet', dscr = 'LocalStorage setItem' },
        fmt([[
localStorage.setItem('{}', {});
]],
            {
                i(1, 'key'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'localRemove', dscr = 'LocalStorage removeItem' },
        fmt([[
localStorage.removeItem('{}');
]],
            {
                i(0, 'key'),
            }
        )
    ),

    s({ trig = 'localClear', dscr = 'LocalStorage clear' },
        t('localStorage.clear();')
    ),

    s({ trig = 'sessionGet', dscr = 'SessionStorage getItem' },
        fmt([[
sessionStorage.getItem('{}');
]],
            {
                i(0, 'key'),
            }
        )
    ),

    s({ trig = 'sessionSet', dscr = 'SessionStorage setItem' },
        fmt([[
sessionStorage.setItem('{}', {});
]],
            {
                i(1, 'key'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'sessionRemove', dscr = 'SessionStorage removeItem' },
        fmt([[
sessionStorage.removeItem('{}');
]],
            {
                i(0, 'key'),
            }
        )
    ),

    s({ trig = 'sessionClear', dscr = 'SessionStorage clear' },
        t('sessionStorage.clear();')
    ),

    ---------------------------------------
    -- 14. Async / Await
    ---------------------------------------

    s({ trig = 'await', dscr = 'Await promise' },
        fmt([[
await {};
]],
            {
                i(0, 'promise'),
            }
        )
    ),

    s({ trig = 'promiseAll', dscr = 'Promise.all' },
        fmt([[
await Promise.all([{}]);
]],
            {
                i(0, 'promises'),
            }
        )
    ),

    s({ trig = 'promiseRace', dscr = 'Promise.race' },
        fmt([[
await Promise.race([{}]);
]],
            {
                i(0, 'promises'),
            }
        )
    ),

    s({ trig = 'promiseAllSettled', dscr = 'Promise.allSettled' },
        fmt([[
await Promise.allSettled([{}]);
]],
            {
                i(0, 'promises'),
            }
        )
    ),

    s({ trig = 'promiseAny', dscr = 'Promise.any' },
        fmt([[
await Promise.any([{}]);
]],
            {
                i(0, 'promises'),
            }
        )
    ),

    s({ trig = 'fetch', dscr = 'Fetch API' },
        fmt([[
fetch('{}', {{
    method: '{}',
    headers: {{
        'Content-Type': 'application/json'
    }},
    body: JSON.stringify({})
}})
    .then(response => response.json())
    .then(data => console.log(data))
    .catch(error => console.error(error));
]],
            {
                i(1, 'url'),
                c(2, { t('GET'), t('POST'), t('PUT'), t('DELETE'), t('PATCH') }),
                i(0, 'data'),
            }
        )
    ),

    s({ trig = 'fetchAsync', dscr = 'Fetch API (async/await)' },
        fmt([[
async function {}() {{
    try {{
        const response = await fetch('{}', {{
            method: '{}',
            headers: {{
                'Content-Type': 'application/json'
            }},
            body: JSON.stringify({})
        }});
        const data = await response.json();
        return data;
    }} catch (error) {{
        console.error(error);
    }}
}}
]],
            {
                i(1, 'fetchData'),
                i(2, 'url'),
                c(3, { t('GET'), t('POST'), t('PUT'), t('DELETE'), t('PATCH') }),
                i(0, 'data'),
            }
        )
    ),

    ---------------------------------------
    -- 15. ES6+ Features
    ---------------------------------------

    s({ trig = 'export', dscr = 'Export default' },
        fmt([[
export default {};
]],
            {
                i(0, 'function'),
            }
        )
    ),

    s({ trig = 'exportn', dscr = 'Named export' },
        fmt([[
export const {} = {};
]],
            {
                i(1, 'name'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'exportf', dscr = 'Export function' },
        fmt([[
export function {}({}) {{
    {}
}}
]],
            {
                i(1, 'name'),
                i(2, 'arg'),
                i(0),
            }
        )
    ),

    s({ trig = 'import', dscr = 'Import default' },
        fmt([[
import {} from '{}';
]],
            {
                i(1, 'module'),
                i(0, './module'),
            }
        )
    ),

    s({ trig = 'importn', dscr = 'Named import' },
        fmt([[
{{ {} }} from '{}';
]],
            {
                i(1, 'a, b'),
                i(0, './module'),
            }
        )
    ),

    s({ trig = 'importas', dscr = 'Import as' },
        fmt([[
import * as {} from '{}';
]],
            {
                i(1, 'name'),
                i(0, './module'),
            }
        )
    ),

    s({ trig = 'module', dscr = 'Module script' },
        fmt([[
<script type="module">
    {}
</script>
]],
            {
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 16. Type Checking
    ---------------------------------------

    s({ trig = 'typeof', dscr = 'Typeof' },
        fmt([[
typeof {}
]],
            {
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'instanceof', dscr = 'Instanceof' },
        fmt([[
{} instanceof {}
]],
            {
                i(1, 'obj'),
                i(0, 'Class'),
            }
        )
    ),

    s({ trig = 'isArray', dscr = 'Array.isArray' },
        fmt([[
Array.isArray({});
]],
            {
                i(1, 'value'),
            }
        )
    ),

    s({ trig = 'isNaN', dscr = 'isNaN' },
        fmt([[
isNaN({});
]],
            {
                i(1, 'value'),
            }
        )
    ),

    s({ trig = 'isFinite', dscr = 'isFinite' },
        fmt([[
isFinite({});
]],
            {
                i(1, 'value'),
            }
        )
    ),

    ---------------------------------------
    -- 17. Strings
    ---------------------------------------

    s({ trig = 'includes', dscr = 'String includes' },
        fmt([[
{}.includes('{}');
]],
            {
                i(1, 'string'),
                i(0, 'substring'),
            }
        )
    ),

    s({ trig = 'startsWith', dscr = 'String startsWith' },
        fmt([[
{}.startsWith('{}');
]],
            {
                i(1, 'string'),
                i(0, 'prefix'),
            }
        )
    ),

    s({ trig = 'endsWith', dscr = 'String endsWith' },
        fmt([[
{}.endsWith('{}');
]],
            {
                i(1, 'string'),
                i(0, 'suffix'),
            }
        )
    ),

    s({ trig = 'replace', dscr = 'String replace' },
        fmt([[
{}.replace('{}', '{}');
]],
            {
                i(1, 'string'),
                i(2, 'pattern'),
                i(0, 'replacement'),
            }
        )
    ),

    s({ trig = 'replaceAll', dscr = 'String replaceAll' },
        fmt([[
{}.replaceAll('{}', '{}');
]],
            {
                i(1, 'string'),
                i(2, 'pattern'),
                i(0, 'replacement'),
            }
        )
    ),

    s({ trig = 'trim', dscr = 'String trim' },
        fmt([[
{}.trim();
]],
            {
                i(1, 'string'),
            }
        )
    ),

    s({ trig = 'split', dscr = 'String split' },
        fmt([[
{}.split('{}');
]],
            {
                i(1, 'string'),
                i(0, 'separator'),
            }
        )
    ),

    s({ trig = 'substring', dscr = 'String substring' },
        fmt([[
{}.substring({}, {});
]],
            {
                i(1, 'string'),
                i(2, 'start'),
                i(0, 'end'),
            }
        )
    ),

    s({ trig = 'repeat', dscr = 'String repeat' },
        fmt([[
{}.repeat({});
]],
            {
                i(1, 'string'),
                i(0, 'count'),
            }
        )
    ),

    s({ trig = 'padStart', dscr = 'String padStart' },
        fmt([[
{}.padStart({}, '{}');
]],
            {
                i(1, 'string'),
                i(2, 'length'),
                i(0, 'char'),
            }
        )
    ),

    s({ trig = 'padEnd', dscr = 'String padEnd' },
        fmt([[
{}.padEnd({}, '{}');
]],
            {
                i(1, 'string'),
                i(2, 'length'),
                i(0, 'char'),
            }
        )
    ),

    ---------------------------------------
    -- 18. Numbers
    ---------------------------------------

    s({ trig = 'parseInt', dscr = 'ParseInt' },
        fmt([[
parseInt({}, {});
]],
            {
                i(1, 'string'),
                i(0, '10'),
            }
        )
    ),

    s({ trig = 'parseFloat', dscr = 'ParseFloat' },
        fmt([[
parseFloat({});
]],
            {
                i(1, 'string'),
            }
        )
    ),

    s({ trig = 'toFixed', dscr = 'ToFixed' },
        fmt([[
{}.toFixed({});
]],
            {
                i(1, 'number'),
                i(0, '2'),
            }
        )
    ),

    s({ trig = 'toPrecision', dscr = 'ToPrecision' },
        fmt([[
{}.toPrecision({});
]],
            {
                i(1, 'number'),
                i(0, '2'),
            }
        )
    ),

    s({ trig = 'Number', dscr = 'Number constructor' },
        fmt([[
Number({});
]],
            {
                i(1, 'value'),
            }
        )
    ),

    ---------------------------------------
    -- 19. Math
    ---------------------------------------

    s({ trig = 'Math', dscr = 'Math object' },
        fmt([[
Math.{};
]],
            {
                c(1,
                    { t('abs()'), t('ceil()'), t('floor()'), t('round()'), t('max()'), t('min()'), t('pow()'), t(
                        'sqrt()'), t('random()'), t('floor(Math.random() * )') }),
            }
        )
    ),

    ---------------------------------------
    -- 20. Console Methods
    ---------------------------------------

    s({ trig = 'assert', dscr = 'Console assert' },
        fmt([[
console.assert({}, {});
]],
            {
                i(1, 'condition'),
                i(0, 'message'),
            }
        )
    ),

    s({ trig = 'clear', dscr = 'Console clear' },
        t('console.clear();')
    ),

    s({ trig = 'count', dscr = 'Console count' },
        fmt([[
console.count('{}');
]],
            {
                i(0, 'label'),
            }
        )
    ),

    s({ trig = 'countReset', dscr = 'Console countReset' },
        fmt([[
console.countReset('{}');
]],
            {
                i(0, 'label'),
            }
        )
    ),

    s({ trig = 'profile', dscr = 'Console profile' },
        fmt([[
console.profile('{}');
]],
            {
                i(0, 'label'),
            }
        )
    ),

    s({ trig = 'profileEnd', dscr = 'Console profileEnd' },
        fmt([[
console.profileEnd('{}');
]],
            {
                i(0, 'label'),
            }
        )
    ),

    s({ trig = 'timeLog', dscr = 'Console timeLog' },
        fmt([[
console.timeLog('{}', {});
]],
            {
                i(1, 'timer'),
                i(0, 'data'),
            }
        )
    ),
}
