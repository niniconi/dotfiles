local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local rep = require('luasnip.extras').rep

return {
    ---------------------------------------
    -- 1. General Python
    ---------------------------------------

    s({ trig = 'main', dscr = 'Python main entry point' },
        fmt([[
if __name__ == "__main__":
    {}
]],
            {
                i(1, 'main()'),
            }
        )
    ),

    s({ trig = 'defmain', dscr = 'Python main entry with function' },
        fmt([[
def {}({}):
    {}

if __name__ == "__main__":
    {}({})
]],
            {
                i(1, 'main'),
                i(2, 'args'),
                i(3, 'pass'),
                f(function(nodes) return nodes[1] end, { 1 }),
                f(function(nodes) return nodes[1] end, { 2 }),
            }
        )
    ),

    s({ trig = 'def', dscr = 'Function definition' },
        fmt([[
def {}({}):
    {}
    {}
]],
            {
                i(1, 'func_name'),
                i(2, 'arg1, arg2'),
                i(3, '"""Docstring"""'),
                i(0),
            }
        )
    ),

    s({ trig = 'cls', dscr = 'Class definition' },
        fmt([[
class {}({}):
    def __init__(self, {}):
        {}

    {}
]],
            {
                i(1, 'ClassName'),
                i(2, 'object'),
                i(3, 'self, arg'),
                i(4, 'self.arg = arg'),
                i(0),
            }
        )
    ),

    s({ trig = 'for', dscr = 'Iterate over a collection' },
        fmt([[
for {} in {}:
    {}
]],
            {
                i(1, 'item'),
                i(2, 'collection'),
                i(0),
            }
        )
    ),

    s({ trig = 'pdb', dscr = 'Pdb breakpoint' },
        t('import pdb; pdb.set_trace()')
    ),

    s({ trig = 'openrb', dscr = 'open a file with rb flag' },
        fmt([[
with open({},{}) as f:
   {}
]],
            {
                i(1, '"file"'),
                i(2, '"rb"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'openwb', dscr = 'open a file with wb flag' },
        fmt([[
with open({},{}) as f:
   {}
]],
            {
                i(1, '"file"'),
                i(2, '"wb"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'openr', dscr = 'open a file with r flag' },
        fmt([[
with open({},{}) as f:
   {}
]],
            {
                i(1, '"file"'),
                i(2, '"r"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'openw', dscr = 'open a file with w flag' },
        fmt([[
with open({},{}) as f:
   {}
]],
            {
                i(1, '"file"'),
                i(2, '"w"'),
                i(3, 'pass'),
            }
        )
    ),

    s({ trig = 'try', dscr = 'Try except block' },
        fmt([[
try:
    {}
except {} as e:
    {}
]],
            {
                i(1, 'pass'),
                i(2, 'Exception'),
                i(0, 'print(e)'),
            }
        )
    ),

    s({ trig = 'tryef', dscr = 'Try except finally block' },
        fmt([[
try:
    {}
except {} as e:
    {}
finally:
    {}
]],
            {
                i(1, 'pass'),
                i(2, 'Exception'),
                i(3, 'print(e)'),
                i(0),
            }
        )
    ),

    s({ trig = 'lambda', dscr = 'Lambda function' },
        fmt([[
lambda {}: {}
]],
            {
                i(1, 'x'),
                i(0, 'x * 2'),
            }
        )
    ),

    s({ trig = 'decorator', dscr = 'Decorator function' },
        fmt([[
def {}():
    @wraps(func)
    def wrapper(*args, **kwargs):
        {}
        return func(*args, **kwargs)
    return wrapper
]],
            {
                i(1, 'decorator_name'),
                i(0),
            }
        )
    ),

    s({ trig = 'dataclass', dscr = 'Dataclass definition' },
        fmt([[
from dataclasses import dataclass

@dataclass
class {}:
    {}
]],
            {
                i(1, 'MyClass'),
                i(0, 'field: str'),
            }
        )
    ),

    s({ trig = 'enum', dscr = 'Enum class definition' },
        fmt([[
from enum import Enum

class {}(Enum):
    {}
]],
            {
                i(1, 'MyEnum'),
                i(0, 'VALUE1 = "value1"'),
            }
        )
    ),

    s({ trig = 'listcomp', dscr = 'List comprehension' },
        fmt([[
[{} for {} in {}]
]],
            {
                i(1, 'x'),
                i(2, 'x'),
                i(3, 'collection'),
            }
        )
    ),

    s({ trig = 'dictcomp', dscr = 'Dictionary comprehension' },
        fmt([[
{{{}: {} for {} in {}}}
]],
            {
                i(1, 'k'),
                i(2, 'v'),
                i(3, 'k, v'),
                i(4, 'dict.items()'),
            }
        )
    ),

    s({ trig = 'with', dscr = 'Context manager' },
        fmt([[
with {} as {}:
    {}
]],
            {
                i(1, 'open("file")'),
                i(2, 'f'),
                i(0),
            }
        )
    ),

    s({ trig = 'yield', dscr = 'Generator function' },
        fmt([[
def {}():
    for {} in {}:
        yield {}
]],
            {
                i(1, 'generator'),
                i(2, 'item'),
                i(3, 'collection'),
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'property', dscr = 'Property decorator' },
        fmt([[
@property
def {}(self):
    return self.{}
]],
            {
                i(1, 'my_property'),
                i(0, '_property'),
            }
        )
    ),

    s({ trig = 'staticmethod', dscr = 'Static method' },
        fmt([[
@staticmethod
def {}():
    {}
]],
            {
                i(1, 'my_method'),
                i(0),
            }
        )
    ),

    s({ trig = 'classmethod', dscr = 'Class method' },
        fmt([[
@classmethod
def {}(cls, {}):
    {}
]],
            {
                i(1, 'my_method'),
                i(2, 'arg'),
                i(0),
            }
        )
    ),

    s({ trig = 'abc', dscr = 'Abstract base class' },
        fmt([[
from abc import ABC, abstractmethod

class {}(ABC):
    @abstractmethod
    def {}():
        pass
]],
            {
                i(1, 'MyBaseClass'),
                i(0, 'my_method'),
            }
        )
    ),

    s({ trig = 'match', dscr = 'Match case statement (Python 3.10+)' },
        fmt([[
match {}:
    case {}:
        {}
    case _:
        {}
]],
            {
                i(1, 'variable'),
                i(2, 'pattern'),
                i(3, 'pass'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 2. Web Scraping
    ---------------------------------------

    s({ trig = 'ireqbs', dscr = 'Import requests and BeautifulSoup' },
        t({
            'import requests',
            'from bs4 import BeautifulSoup',
            '# ----------------------------',
        })
    ),

    s({ trig = 'rget', dscr = 'requests.get template' },
        fmt([[
url = '{}'
headers = {{
    'User-Agent': '{}'
}}
response = requests.get(url, headers=headers)
response.raise_for_status()
{}
]],
            {
                i(1, 'https://example.com'),
                i(2, 'Mozilla/5.0...'),
                i(0, 'print(response.text)'),
            }
        )
    ),

    s({ trig = 'bsoup', dscr = 'BeautifulSoup initialization' },
        fmt([[
soup = BeautifulSoup({}, 'html.parser')
{} = soup.select_one('{}')
{}
]],
            {
                i(1, 'response.text'),
                i(2, 'element'),
                i(3, 'div#main'),
                i(0, 'print(element.text)'),
            }
        )
    ),

    s({ trig = 'wcsv', dscr = 'Write data to CSV file' },
        fmt([[
import csv

with open('{}', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow([{}])
    for row in {}:
        writer.writerow(row)
]],
            {
                i(1, 'data.csv'),
                i(2, '"Col1", "Col2"'),
                i(3, 'scraped_data'),
            }
        )
    ),

    ---------------------------------------
    -- 3. Pwn Snippets (Pwntools)
    ---------------------------------------

    s({ trig = 'pwninit', dscr = 'Pwntools basic template' },
        fmt([[
from pwn import *

context.update(arch='{}', os='linux')
context.log_level = '{}'

HOST = '{}'
PORT = {}

def start(argv=[], *a, **kw):
    if args.REMOTE:
        return remote(HOST, PORT)
    else:
        return process([{}], *a, **kw)

io = start()
{}

# io.interactive()
{}
]],
            {
                c(1, { t('amd64'), t('i386') }),
                c(2, { t('info'), t('debug') }),
                i(3, '127.0.0.1'),
                i(4, '1337'),
                i(5, './target'),
                i(6, 'info("Payload construction...")'),
                i(0, 'io.interactive()'),
            }
        )
    ),

    s({ trig = 'pu', dscr = 'Pack/Unpack functions' },
        fmt([[
def p(addr):
    return p{} (addr)

def u(data):
    return u{} (data)
]],
            {
                c(1, { t('32'), t('64') }),
                rep(1)
            }
        )
    ),

    s({ trig = 'gdbatt', dscr = 'GDB attach' },
        fmt([[
if args.LOCAL:
    gdb.attach(io, gdbscript='''
        b *{}
        c
    ''')
    pause()
]],
            {
                i(1, '0xdeadbeef'),
            }
        )
    ),

    s({ trig = 'sl', dscr = 'io.sendline()' },
        fmt([[
io.sendline({})
]],
            {
                i(1, 'payload'),
            }
        )
    ),

    s({ trig = 'sla', dscr = 'io.sendlineafter()' },
        fmt([[
io.sendlineafter({}, {})
]],
            {
                i(1, 'after'),
                i(2, 'payload'),
            }
        )
    ),

    s({ trig = 's', dscr = 'io.send()' },
        fmt([[
io.send({})
]],
            {
                i(1, 'payload'),
            }
        )
    ),

    s({ trig = 'sa', dscr = 'io.sendafter()' },
        fmt([[
io.sendafter({}, {})
]],
            {
                i(1, 'after'),
                i(2, 'payload'),
            }
        )
    ),

    ---------------------------------------
    -- 4. Scientific Computing (NumPy)
    ---------------------------------------

    s({ trig = 'inp', dscr = 'Import NumPy' },
        t('import numpy as np')
    ),

    s({ trig = 'nparray', dscr = 'NumPy array creation' },
        fmt([[
np.array([{}])
]],
            {
                i(0, '1, 2, 3'),
            }
        )
    ),

    s({ trig = 'nparray2d', dscr = 'NumPy 2D array' },
        fmt([[
np.array([{}])
]],
            {
                i(0, '[1, 2, 3], [4, 5, 6]'),
            }
        )
    ),

    s({ trig = 'nparange', dscr = 'NumPy arange' },
        fmt([[
np.arange({}, {}, {})
]],
            {
                i(1, '0'),
                i(2, '10'),
                i(3, '1'),
            }
        )
    ),

    s({ trig = 'nplinspace', dscr = 'NumPy linspace' },
        fmt([[
np.linspace({}, {}, {})
]],
            {
                i(1, '0'),
                i(2, '10'),
                i(3, '50'),
            }
        )
    ),

    s({ trig = 'npzeros', dscr = 'NumPy zeros array' },
        fmt([[
np.zeros(({}, {}))
]],
            {
                i(1, '3'),
                i(2, '3'),
            }
        )
    ),

    s({ trig = 'npones', dscr = 'NumPy ones array' },
        fmt([[
np.ones(({}, {}))
]],
            {
                i(1, '3'),
                i(2, '3'),
            }
        )
    ),

    s({ trig = 'npeye', dscr = 'NumPy identity matrix' },
        fmt([[
np.eye({})
]],
            {
                i(1, '3'),
            }
        )
    ),

    s({ trig = 'nprand', dscr = 'NumPy random array' },
        fmt([[
np.random.rand({}, {})
]],
            {
                i(1, '3'),
                i(2, '3'),
            }
        )
    ),

    s({ trig = 'nprandint', dscr = 'NumPy random integer' },
        fmt([[
np.random.randint({}, {}, size=({}, {}))
]],
            {
                i(1, '0'),
                i(2, '10'),
                i(3, '3'),
                i(4, '3'),
            }
        )
    ),

    s({ trig = 'npreshape', dscr = 'NumPy reshape' },
        fmt([[
{}.reshape({}, {})
]],
            {
                i(1, 'arr'),
                i(2, '-1'),
                i(0, '1'),
            }
        )
    ),

    s({ trig = 'nptranspose', dscr = 'NumPy transpose' },
        fmt([[
{}.T
# or
np.transpose({})
]],
            {
                rep(1),
                rep(1),
            }
        )
    ),

    s({ trig = 'npdot', dscr = 'NumPy dot product' },
        fmt([[
np.dot({}, {})
# or
{} @ {}
]],
            {
                i(1, 'a'),
                i(2, 'b'),
                rep(1),
                rep(2),
            }
        )
    ),

    s({ trig = 'npmatmul', dscr = 'NumPy matrix multiplication' },
        fmt([[
np.matmul({}, {})
]],
            {
                i(1, 'a'),
                i(0, 'b'),
            }
        )
    ),

    s({ trig = 'npconcat', dscr = 'NumPy concatenate' },
        fmt([[
np.concatenate([{}, {}], axis={})
]],
            {
                i(1, 'arr1'),
                i(2, 'arr2'),
                i(3, '0'),
            }
        )
    ),

    s({ trig = 'npsum', dscr = 'NumPy sum' },
        fmt([[
np.sum({}, axis={})
]],
            {
                i(1, 'arr'),
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'npmaxmin', dscr = 'NumPy max/min' },
        fmt([[
np.max({})
# np.min({})
]],
            {
                i(1, 'arr'),
                i(2, 'arr'),
            }
        )
    ),

    s({ trig = 'npargmax', dscr = 'NumPy argmax/argmin' },
        fmt([[
np.argmax({})
# np.argmin({})
]],
            {
                i(1, 'arr'),
                i(2, 'arr'),
            }
        )
    ),

    s({ trig = 'npwhere', dscr = 'NumPy where' },
        fmt([[
np.where({}, {}, {})
]],
            {
                i(1, 'condition'),
                i(2, 'x'),
                i(0, 'y'),
            }
        )
    ),

    s({ trig = 'npunique', dscr = 'NumPy unique' },
        fmt([[
np.unique({}, return_counts={})
]],
            {
                i(1, 'arr'),
                i(0, 'False'),
            }
        )
    ),

    s({ trig = 'npsave', dscr = 'NumPy save/load' },
        fmt([[
np.save('{}', {})
# np.load('{}.npy')
]],
            {
                i(1, 'array'),
                i(0, 'arr'),
                i(2, 'arr'),
            }
        )
    ),

    ---------------------------------------
    -- 5. Pandas
    ---------------------------------------

    s({ trig = 'ipd', dscr = 'Import Pandas' },
        t('import pandas as pd')
    ),

    s({ trig = 'pddf', dscr = 'Pandas DataFrame creation' },
        fmt([[
pd.DataFrame({{
    '{}': [{}],
    '{}': [{}]
}})
]],
            {
                i(1, 'col1'),
                i(2, 'val1, val2'),
                i(3, 'col2'),
                i(0, 'val1, val2'),
            }
        )
    ),

    s({ trig = 'pdreadcsv', dscr = 'Pandas read CSV' },
        fmt([[
pd.read_csv('{}')
]],
            {
                i(1, 'file.csv'),
            }
        )
    ),

    s({ trig = 'pdreadxlsx', dscr = 'Pandas read Excel' },
        fmt([[
pd.read_excel('{}')
]],
            {
                i(1, 'file.xlsx'),
            }
        )
    ),

    s({ trig = 'pdreadjson', dscr = 'Pandas read JSON' },
        fmt([[
pd.read_json('{}')
]],
            {
                i(1, 'file.json'),
            }
        )
    ),

    s({ trig = 'pdreadsql', dscr = 'Pandas read SQL' },
        fmt([[
pd.read_sql('{}', {})
]],
            {
                i(1, 'SELECT * FROM table'),
                i(0, 'connection'),
            }
        )
    ),

    s({ trig = 'pddftocsv', dscr = 'DataFrame to CSV' },
        fmt([[
{}.to_csv('{}', index={})
]],
            {
                i(1, 'df'),
                i(2, 'output.csv'),
                i(0, 'False'),
            }
        )
    ),

    s({ trig = 'pddftocsv', dscr = 'DataFrame to Excel' },
        fmt([[
{}.to_excel('{}', index={})
]],
            {
                i(1, 'df'),
                i(2, 'output.xlsx'),
                i(0, 'False'),
            }
        )
    ),

    s({ trig = 'pdhead', dscr = 'DataFrame head' },
        fmt([[
{}.head({})
]],
            {
                i(1, 'df'),
                i(0, '10'),
            }
        )
    ),

    s({ trig = 'pdinfo', dscr = 'DataFrame info' },
        fmt([[
{}.info()
]],
            {
                i(1, 'df'),
            }
        )
    ),

    s({ trig = 'pddescribe', dscr = 'DataFrame describe' },
        fmt([[
{}.describe()
]],
            {
                i(1, 'df'),
            }
        )
    ),

    s({ trig = 'pdgroupby', dscr = 'DataFrame groupby' },
        fmt([[
{}.groupby('{}').{}()
]],
            {
                i(1, 'df'),
                i(2, 'column'),
                i(0, 'sum'),
            }
        )
    ),

    s({ trig = 'pdmerge', dscr = 'DataFrame merge' },
        fmt([[
pd.merge({}, {}, on='{}', how='{}')
]],
            {
                i(1, 'df1'),
                i(2, 'df2'),
                i(3, 'column'),
                i(0, 'inner'),
            }
        )
    ),

    s({ trig = 'pdconcat', dscr = 'DataFrame concat' },
        fmt([[
pd.concat([{}, {}], axis={})
]],
            {
                i(1, 'df1'),
                i(2, 'df2'),
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'pdapply', dscr = 'DataFrame apply' },
        fmt([[
{}.apply(lambda x: {})
]],
            {
                i(1, 'df'),
                i(0, 'x'),
            }
        )
    ),

    s({ trig = 'pdfillna', dscr = 'DataFrame fillna' },
        fmt([[
{}.fillna({})
]],
            {
                i(1, 'df'),
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'pddropna', dscr = 'DataFrame dropna' },
        fmt([[
{}.dropna(axis={}, how='{}')
]],
            {
                i(1, 'df'),
                i(2, '0'),
                i(0, 'any'),
            }
        )
    ),

    s({ trig = 'pdloc', dscr = 'DataFrame loc' },
        fmt([[
{}.loc[{}]
]],
            {
                i(1, 'df'),
                i(0, "condition"),
            }
        )
    ),

    s({ trig = 'pdiloc', dscr = 'DataFrame iloc' },
        fmt([[
{}.iloc[{}]
]],
            {
                i(1, 'df'),
                i(0, '0:10'),
            }
        )
    ),

    s({ trig = 'pddrop', dscr = 'DataFrame drop columns' },
        fmt([[
{}.drop(columns=['{}'])
]],
            {
                i(1, 'df'),
                i(0, 'column'),
            }
        )
    ),

    s({ trig = 'pdrename', dscr = 'DataFrame rename columns' },
        fmt([[
{}.rename(columns={{'{}': '{}'}})
]],
            {
                i(1, 'df'),
                i(2, 'old_name'),
                i(0, 'new_name'),
            }
        )
    ),

    ---------------------------------------
    -- 6. Matplotlib / Seaborn
    ---------------------------------------

    s({ trig = 'implt', dscr = 'Import Matplotlib' },
        t({
            'import matplotlib.pyplot as plt',
            'import matplotlib.cm as cm',
            'import matplotlib.colors as colors',
        })
    ),

    s({ trig = 'isns', dscr = 'Import Seaborn' },
        t('import seaborn as sns')
    ),

    s({ trig = 'pltfig', dscr = 'Matplotlib figure' },
        fmt([[
fig, ax = plt.subplots({}, {}, figsize=({}, {}))
{}
plt.show()
]],
            {
                i(1, '1'),
                i(2, '1'),
                i(3, '10'),
                i(4, '6'),
                i(0),
            }
        )
    ),

    s({ trig = 'pltsave', dscr = 'Save matplotlib figure' },
        fmt([[
plt.savefig('{}', dpi={}, bbox_inches='{}')
]],
            {
                i(1, 'plot.png'),
                i(2, '300'),
                i(0, 'tight'),
            }
        )
    ),

    s({ trig = 'pltplot', dscr = 'Matplotlib plot' },
        fmt([[
ax.plot({}, {}, label='{}')
ax.set_xlabel('{}')
ax.set_ylabel('{}')
ax.set_title('{}')
ax.legend()
]],
            {
                i(1, 'x'),
                i(2, 'y'),
                i(3, 'label'),
                i(4, 'X'),
                i(5, 'Y'),
                i(0, 'Title'),
            }
        )
    ),

    s({ trig = 'pltscatter', dscr = 'Matplotlib scatter plot' },
        fmt([[
ax.scatter({}, {}, c='{}', s={})
]],
            {
                i(1, 'x'),
                i(2, 'y'),
                i(3, 'blue'),
                i(0, '50'),
            }
        )
    ),

    s({ trig = 'plthist', dscr = 'Matplotlib histogram' },
        fmt([[
ax.hist({}, bins={}, color='{}', alpha={})
]],
            {
                i(1, 'data'),
                i(2, '30'),
                i(3, 'steelblue'),
                i(0, '0.7'),
            }
        )
    ),

    s({ trig = 'pltbar', dscr = 'Matplotlib bar chart' },
        fmt([[
ax.bar({}, {}, color='{}')
]],
            {
                i(1, 'x'),
                i(2, 'height'),
                i(0, 'steelblue'),
            }
        )
    ),

    s({ trig = 'pltimshow', dscr = 'Matplotlib imshow' },
        fmt([[
ax.imshow({}, cmap='{}', aspect='{}')
]],
            {
                i(1, 'data'),
                i(2, 'viridis'),
                i(0, 'auto'),
            }
        )
    ),

    s({ trig = 'pltheatmap', dscr = 'Seaborn heatmap' },
        fmt([[
sns.heatmap({}, annot={}, cmap='{}', fmt='{}', linewidths={})
]],
            {
                i(1, 'data'),
                i(2, 'True'),
                i(3, 'coolwarm'),
                i(4, '.2f'),
                i(0, '0.5'),
            }
        )
    ),

    s({ trig = 'snsbox', dscr = 'Seaborn boxplot' },
        fmt([[
sns.boxplot(x='{}', y='{}', data={})
]],
            {
                i(1, 'x_col'),
                i(2, 'y_col'),
                i(0, 'df'),
            }
        )
    ),

    s({ trig = 'snsviolin', dscr = 'Seaborn violinplot' },
        fmt([[
sns.violinplot(x='{}', y='{}', data={})
]],
            {
                i(1, 'x_col'),
                i(2, 'y_col'),
                i(0, 'df'),
            }
        )
    ),

    s({ trig = 'snspair', dscr = 'Seaborn pairplot' },
        fmt([[
sns.pairplot({}, hue='{}')
]],
            {
                i(1, 'df'),
                i(0, 'column'),
            }
        )
    ),

    ---------------------------------------
    -- 7. Z3 / SMT Solver
    ---------------------------------------

    s({ trig = 'iz3', dscr = 'Import Z3' },
        t('from z3 import *')
    ),

    s({ trig = 'z3solver', dscr = 'Z3 basic solver' },
        fmt([[
s = Solver()
s.add({})
result = s.check()
print(result)
if result == sat:
    print(s.model())
]],
            {
                i(1, 'condition'),
            }
        )
    ),

    s({ trig = 'z3opt', dscr = 'Z3 optimization' },
        fmt([[
opt = Optimize()
opt.add({})
opt.minimize({})
result = opt.check()
print(result)
if result == sat:
    print(opt.model())
]],
            {
                i(1, 'constraints'),
                i(0, 'objective'),
            }
        )
    ),

    s({ trig = 'z3int', dscr = 'Z3 Int variable' },
        fmt([[
{} = Int('{}')
]],
            {
                i(1, 'x'),
                i(0, 'x'),
            }
        )
    ),

    s({ trig = 'z3real', dscr = 'Z3 Real variable' },
        fmt([[
{} = Real('{}')
]],
            {
                i(1, 'x'),
                i(0, 'x'),
            }
        )
    ),

    s({ trig = 'z3bool', dscr = 'Z3 Bool variable' },
        fmt([[
{} = Bool('{}')
]],
            {
                i(1, 'p'),
                i(0, 'p'),
            }
        )
    ),

    s({ trig = 'z3bv', dscr = 'Z3 BitVector' },
        fmt([[
{} = BitVec('{}', {})
]],
            {
                i(0, 'x'),
                i(1, 'x'),
                i(2, '64'),
            }
        )
    ),

    s({ trig = 'z3array', dscr = 'Z3 Array' },
        fmt([[
{} = Array('{}', {}, {})
]],
            {
                i(1, 'arr'),
                rep(1),
                i(2, 'IntSort()'),
                i(0, 'IntSort()'),
            }
        )
    ),

    s({ trig = 'z3list', dscr = 'Z3 List' },
        fmt([[
{} = List('{}', {})
]],
            {
                i(2, 'lst'),
                i(1, 'lst'),
                i(0, 'IntSort()'),
            }
        )
    ),

    s({ trig = 'z3sat', dscr = 'Z3 sat check' },
        t("s.check() == sat")
    ),

    s({ trig = 'z3unsat', dscr = 'Z3 unsat check' },
        t("s.check() == unsat")
    ),

    s({ trig = 'z3model', dscr = 'Z3 get model' },
        t("s.model()")
    ),

    s({ trig = 'z3forall', dscr = 'Z3 ForAll quantifier' },
        fmt([[
ForAll({}, {})
]],
            {
                i(1, '[x, y]'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'z3exists', dscr = 'Z3 Exists quantifier' },
        fmt([[
Exists({}, {})
]],
            {
                i(1, '[x, y]'),
                i(0, 'condition'),
            }
        )
    ),

    s({ trig = 'z3simplify', dscr = 'Z3 simplify' },
        fmt([[
simplify({})
]],
            {
                i(1, 'expr'),
            }
        )
    ),

    s({ trig = 'z3substitute', dscr = 'Z3 substitute' },
        fmt([[
substitute({}, ({}, {}))
]],
            {
                i(1, 'expr'),
                i(2, 'x'),
                i(0, 'new_x'),
            }
        )
    ),

    s({ trig = 'z3distinct', dscr = 'Z3 Distinct' },
        fmt([[
Distinct({})
]],
            {
                i(0, 'x, y, z'),
            }
        )
    ),

    s({ trig = 'z3sum', dscr = 'Z3 Sum' },
        fmt([[
Sum({})
]],
            {
                i(0, '[x, y, z]'),
            }
        )
    ),

    s({ trig = 'z3product', dscr = 'Z3 Product' },
        fmt([[
Product({})
]],
            {
                i(0, '[x, y, z]'),
            }
        )
    ),

    ---------------------------------------
    -- 8. CLI / Automation
    ---------------------------------------

    s({ trig = 'iargparse', dscr = 'Import argparse' },
        t('import argparse')
    ),

    s({ trig = 'argp', dscr = 'Argparse template' },
        fmt([[
parser = argparse.ArgumentParser(description='{}')
parser.add_argument('{}', type={}, help='{}')
parser.add_argument('-{}', '--{}', type={}, default={}, help='{}')
args = parser.parse_args()
]],
            {
                i(1, 'Description'),
                i(2, 'input_file'),
                i(3, 'str'),
                i(4, 'Input file'),
                i(5, 'verbose'),
                i(6, 'verbose'),
                i(7, 'int'),
                i(8, '0'),
                i(0, 'Verbose level'),
            }
        )
    ),

    s({ trig = 'argpbool', dscr = 'Argparse boolean flag' },
        fmt([[
parser.add_argument('-{}', '--{}', action='store_true', help='{}')
]],
            {
                i(1, 'v'),
                i(2, 'verbose'),
                i(0, 'Enable verbose output'),
            }
        )
    ),

    s({ trig = 'iclick', dscr = 'Import click' },
        t('import click')
    ),

    s({ trig = 'clickcmd', dscr = 'Click command template' },
        fmt([[
@click.command()
@click.argument('{}')
@click.option('-{}', '--{}', default={}, help='{}')
def {}({}, {}):
    {}
]],
            {
                i(1, 'filename'),
                i(2, 'opt'),
                i(3, 'option'),
                i(4, 'default'),
                i(5, 'Help text'),
                i(6, 'cli'),
                i(7, 'filename'),
                i(8, 'option'),
                i(0, 'pass'),
            }
        )
    ),

    s({ trig = 'icli', dscr = 'Import typer' },
        t('import typer')
    ),

    s({ trig = 'typerapp', dscr = 'Typer app template' },
        fmt([[
app = typer.Typer()

@app.command()
def {}({}: {}):
    {}
]],
            {
                i(1, 'main'),
                i(2, 'name'),
                i(3, 'str'),
                i(0, 'typer.echo(f"Hello {name}")'),
            }
        )
    ),

    s({ trig = 'isubprocess', dscr = 'Import subprocess' },
        t('import subprocess')
    ),

    s({ trig = 'subpopen', dscr = 'Subprocess run command' },
        fmt([[
result = subprocess.run([{}], capture_output=True, text=True)
print(result.stdout)
print(result.stderr)
]],
            {
                i(0, "'ls', '-la'"),
            }
        )
    ),

    s({ trig = 'subpcall', dscr = 'Subprocess call' },
        fmt([[
subprocess.call([{}])
]],
            {
                i(0, "'ls', '-la'"),
            }
        )
    ),

    s({ trig = 'subpcheck', dscr = 'Subprocess check_output' },
        fmt([[
output = subprocess.check_output([{}], text=True)
]],
            {
                i(0, "'ls', '-la'"),
            }
        )
    ),

    s({ trig = 'ishutil', dscr = 'Import shutil' },
        t('import shutil')
    ),

    s({ trig = 'shutilcopy', dscr = 'Shutil copy file' },
        fmt([[
shutil.copy({}, {})
]],
            {
                i(1, 'src'),
                i(0, 'dst'),
            }
        )
    ),

    s({ trig = 'shutilmove', dscr = 'Shutil move file' },
        fmt([[
shutil.move({}, {})
]],
            {
                i(1, 'src'),
                i(0, 'dst'),
            }
        )
    ),

    s({ trig = 'shutilrmtree', dscr = 'Shutil remove directory' },
        fmt([[
shutil.rmtree({})
]],
            {
                i(0, 'dir_path'),
            }
        )
    ),

    s({ trig = 'imkdir', dscr = 'Create directory' },
        fmt([[
import os
os.makedirs({}, exist_ok={})
]],
            {
                i(1, 'dir_path'),
                i(0, 'True'),
            }
        )
    ),

    s({ trig = 'igetpass', dscr = 'Import getpass' },
        t('import getpass')
    ),

    s({ trig = 'getpass', dscr = 'Get password input' },
        fmt([[
password = getpass.getpass(prompt='{}')
]],
            {
                i(0, 'Enter password: '),
            }
        )
    ),

    ---------------------------------------
    -- 9. Testing
    ---------------------------------------

    s({ trig = 'ipytest', dscr = 'Import pytest' },
        t('import pytest')
    ),

    s({ trig = 'pytestfn', dscr = 'Pytest function' },
        fmt([[
def test_{}():
    {}
]],
            {
                i(1, 'function_name'),
                i(0, 'assert True'),
            }
        )
    ),

    s({ trig = 'pytestcls', dscr = 'Pytest class' },
        fmt([[
class Test{}:
    def test_{}(self):
        {}
]],
            {
                i(1, 'MyClass'),
                i(2, 'method'),
                i(0, 'assert True'),
            }
        )
    ),

    s({ trig = 'pytestfix', dscr = 'Pytest fixture' },
        fmt([[
@pytest.fixture
def {}():
    return {}
]],
            {
                i(1, 'my_fixture'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'pytestparam', dscr = 'Pytest parametrize' },
        fmt([[
@pytest.mark.parametrize('{}, [{}])
def test_{}({}, expected):
    assert {}
]],
            {
                i(1, 'arg'),
                i(2, 'val1, val2'),
                i(3, 'func'),
                i(4, 'arg'),
                i(0, 'result'),
            }
        )
    ),

    s({ trig = 'pytestmark', dscr = 'Pytest mark' },
        fmt([[
@pytest.mark.{}
]],
            {
                c(1, { t('skip'), t('skipif'), t('xfail'), t('parametrize') }),
            }
        )
    ),

    s({ trig = 'pytest.raises', dscr = 'Pytest raises' },
        fmt([[
with pytest.raises({}):
    {}
]],
            {
                i(1, 'Exception'),
                i(0),
            }
        )
    ),

    s({ trig = 'pytestsetup', dscr = 'Pytest setup/teardown' },
        fmt([[
def setup_method():
    {}

def teardown_method():
    {}
]],
            {
                i(1, 'pass'),
                i(0),
            }
        )
    ),

    s({ trig = 'iunittest', dscr = 'Import unittest' },
        t('import unittest')
    ),

    s({ trig = 'unittestcls', dscr = 'Unittest class' },
        fmt([[
class Test{}(unittest.TestCase):
    def setUp(self):
        {}

    def tearDown(self):
        {}

    def test_{}(self):
        {}
]],
            {
                i(1, 'MyClass'),
                i(2, 'pass'),
                i(3),
                i(4, 'method'),
                i(0, 'self.assertEqual(1, 1)'),
            }
        )
    ),

    s({ trig = 'unittestmain', dscr = 'Unittest main' },
        t('unittest.main()')
    ),

    s({ trig = 'assertEqual', dscr = 'assertEqual' },
        fmt([[
self.assertEqual({}, {})
]],
            {
                i(1, 'actual'),
                i(0, 'expected'),
            }
        )
    ),

    s({ trig = 'assertTrue', dscr = 'assertTrue' },
        fmt([[
self.assertTrue({})
]],
            {
                i(1, 'condition'),
            }
        )
    ),

    s({ trig = 'assertFalse', dscr = 'assertFalse' },
        fmt([[
self.assertFalse({})
]],
            {
                i(1, 'condition'),
            }
        )
    ),

    s({ trig = 'assertIsNone', dscr = 'assertIsNone' },
        fmt([[
self.assertIsNone({})
]],
            {
                i(1, 'obj'),
            }
        )
    ),

    s({ trig = 'assertIn', dscr = 'assertIn' },
        fmt([[
self.assertIn({}, {})
]],
            {
                i(1, 'member'),
                i(0, 'container'),
            }
        )
    ),

    s({ trig = 'assertRaises', dscr = 'assertRaises' },
        fmt([[
self.assertRaises({}, {})
]],
            {
                i(1, 'Exception'),
                i(0, 'callable'),
            }
        )
    ),

    ---------------------------------------
    -- 10. Web Frameworks
    ---------------------------------------

    s({ trig = 'ifastapi', dscr = 'Import FastAPI' },
        t('from fastapi import FastAPI')
    ),

    s({ trig = 'fastapiapp', dscr = 'FastAPI app template' },
        fmt([[
from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

class {}(BaseModel):
    {}

@app.get("/")
def read_root():
    return {{"message": "{}"}}

@app.get("/{}/{{}}")
def read_item({}: str):
    return {{"{}": {}}}

@app.post("/{}")
def create_item(item: {}):
    return item
]],
            {
                i(1, 'Item'),
                i(2, 'field: str'),
                i(3, 'Hello World'),
                i(4, 'item_id'),
                i(5, 'item_id'),
                i(6, 'item_id'),
                i(7, 'item_id'),
                i(8, 'items'),
                i(0, 'Item'),
            }
        )
    ),

    s({ trig = 'fastapiget', dscr = 'FastAPI GET route' },
        fmt([[
@app.get("/{}")
def {}({}: {}):
    return {{"{}": {}}}
]],
            {
                i(1, 'endpoint'),
                i(2, 'func_name'),
                i(3, 'param'),
                i(4, 'str'),
                i(5, 'param'),
                i(0, 'param'),
            }
        )
    ),

    s({ trig = 'fastapipost', dscr = 'FastAPI POST route' },
        fmt([[
@app.post("/{}")
def {}({}: {}):
    return {}
]],
            {
                i(1, 'endpoint'),
                i(2, 'func_name'),
                i(3, 'item'),
                i(4, 'Item'),
                i(0, 'item'),
            }
        )
    ),

    s({ trig = 'iflasks', dscr = 'Import Flask' },
        t({
            'from flask import Flask, request, jsonify',
            '',
            'app = Flask(__name__)',
        })
    ),

    s({ trig = 'flaskapp', dscr = 'Flask app template' },
        fmt([[
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/', methods=['GET'])
def {}():
    return jsonify({{"message": "{}"}})

@app.route('/{}', methods=['GET'])
def get_{}({}):
    return jsonify({{"{}": {}}})

@app.route('/{}', methods=['POST'])
def create_{}():
    data = request.get_json()
    return jsonify(data), 201

if __name__ == '__main__':
    app.run(debug={})
]],
            {
                i(1, 'index'),
                i(2, 'Hello World'),
                i(3, 'items'),
                i(4, 'get_item'),
                i(5, 'item_id'),
                i(6, 'item_id'),
                i(7, 'item_id'),
                i(8, 'items'),
                i(9, 'create_item'),
                i(0, 'True'),
            }
        )
    ),

    s({ trig = 'flaskroute', dscr = 'Flask route' },
        fmt([[
@app.route('/{}', methods=['GET'])
def {}():
    return jsonify({{"data": {}}})
]],
            {
                i(1, 'endpoint'),
                i(2, 'func_name'),
                i(0),
            }
        )
    ),

    s({ trig = 'flaskjson', dscr = 'Flask jsonify' },
        fmt([[
return jsonify({{"{}": {}}})
]],
            {
                i(1, 'key'),
                i(0, 'value'),
            }
        )
    ),

    ---------------------------------------
    -- 11. Concurrency / Async
    ---------------------------------------

    s({ trig = 'iasyncio', dscr = 'Import asyncio' },
        t('import asyncio')
    ),

    s({ trig = 'asynciomain', dscr = 'Asyncio main function' },
        fmt([[
async def {}():
    {}

asyncio.run({}())
]],
            {
                i(1, 'main'),
                i(2, 'await asyncio.sleep(1)'),
                rep(1),
            }
        )
    ),

    s({ trig = 'asyncdef', dscr = 'Async function' },
        fmt([[
async def {}({}):
    {}
]],
            {
                i(1, 'func_name'),
                i(2, 'arg1, arg2'),
                i(0, 'await something()'),
            }
        )
    ),

    s({ trig = 'asynciotask', dscr = 'Asyncio create task' },
        fmt([[
task = asyncio.create_task({}())
]],
            {
                i(1, 'func_name'),
            }
        )
    ),

    s({ trig = 'asynciogather', dscr = 'Asyncio gather' },
        fmt([[
results = await asyncio.gather({})
]],
            {
                i(0, 'task1(), task2()'),
            }
        )
    ),

    s({ trig = 'asynciowait', dscr = 'Asyncio wait' },
        fmt([[
done, pending = await asyncio.wait({})
]],
            {
                i(0, '[task1, task2]'),
            }
        )
    ),

    s({ trig = 'ithreading', dscr = 'Import threading' },
        t('import threading')
    ),

    s({ trig = 'thread', dscr = 'Thread creation' },
        fmt([[
def {}():
    {}

thread = threading.Thread(target={})
thread.start()
thread.join()
]],
            {
                i(1, 'worker'),
                i(2, 'pass'),
                rep(1),
            }
        )
    ),

    s({ trig = 'threadlock', dscr = 'Thread with lock' },
        fmt([[
lock = threading.Lock()

def {}():
    with lock:
        {}
]],
            {
                i(1, 'worker'),
                i(0),
            }
        )
    ),

    s({ trig = 'imp', dscr = 'Import multiprocessing' },
        t('import multiprocessing')
    ),

    s({ trig = 'mpproc', dscr = 'Multiprocessing process' },
        fmt([[
def {}():
    {}

if __name__ == '__main__':
    p = multiprocessing.Process(target={})
    p.start()
    p.join()
]],
            {
                i(1, 'worker'),
                i(2, 'pass'),
                rep(1),
            }
        )
    ),

    s({ trig = 'mppool', dscr = 'Multiprocessing pool' },
        fmt([[
with multiprocessing.Pool({}) as pool:
    results = pool.map({}, {})
]],
            {
                i(1, '4'),
                i(2, 'func'),
                i(0, 'data'),
            }
        )
    ),

    s({ trig = 'ipool', dscr = 'Import concurrent.futures' },
        t('from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor')
    ),

    s({ trig = 'threadpool', dscr = 'ThreadPoolExecutor' },
        fmt([[
with ThreadPoolExecutor(max_workers={}) as executor:
    future = executor.submit({}, {})
    result = future.result()
]],
            {
                i(1, '4'),
                i(2, 'func'),
                i(0, 'arg'),
            }
        )
    ),

    s({ trig = 'processpool', dscr = 'ProcessPoolExecutor' },
        fmt([[
with ProcessPoolExecutor(max_workers={}) as executor:
    future = executor.submit({}, {})
    result = future.result()
]],
            {
                i(1, '4'),
                i(2, 'func'),
                i(0, 'arg'),
            }
        )
    ),

    ---------------------------------------
    -- 12. File I/O / Serialization
    ---------------------------------------

    s({ trig = 'ijson', dscr = 'Import json' },
        t('import json')
    ),

    s({ trig = 'jsondump', dscr = 'JSON dump' },
        fmt([[
with open('{}', 'w') as f:
    json.dump({}, f, indent={})
]],
            {
                i(1, 'file.json'),
                i(2, 'data'),
                i(0, '2'),
            }
        )
    ),

    s({ trig = 'jsonload', dscr = 'JSON load' },
        fmt([[
with open('{}', 'r') as f:
    {} = json.load(f)
]],
            {
                i(1, 'file.json'),
                i(0, 'data'),
            }
        )
    ),

    s({ trig = 'ijoblib', dscr = 'Import joblib' },
        t('import joblib')
    ),

    s({ trig = 'joblibdump', dscr = 'Joblib dump' },
        fmt([[
joblib.dump({}, '{}')
]],
            {
                i(1, 'model'),
                i(0, 'model.joblib'),
            }
        )
    ),

    s({ trig = 'joblibload', dscr = 'Joblib load' },
        fmt([[
{} = joblib.load('{}')
]],
            {
                i(1, 'model'),
                i(0, 'model.joblib'),
            }
        )
    ),

    s({ trig = 'ipickle', dscr = 'Import pickle' },
        t('import pickle')
    ),

    s({ trig = 'pickledump', dscr = 'Pickle dump' },
        fmt([[
with open('{}', 'wb') as f:
    pickle.dump({}, f)
]],
            {
                i(1, 'file.pkl'),
                i(0, 'obj'),
            }
        )
    ),

    s({ trig = 'pickleload', dscr = 'Pickle load' },
        fmt([[
with open('{}', 'rb') as f:
    {} = pickle.load(f)
]],
            {
                i(1, 'file.pkl'),
                i(0, 'obj'),
            }
        )
    ),

    s({ trig = 'iyaml', dscr = 'Import yaml' },
        t('import yaml')
    ),

    s({ trig = 'yamldump', dscr = 'YAML dump' },
        fmt([[
with open('{}', 'w') as f:
    yaml.dump({}, f, default_flow_style={})
]],
            {
                i(1, 'file.yaml'),
                i(2, 'data'),
                i(0, 'False'),
            }
        )
    ),

    s({ trig = 'yamlload', dscr = 'YAML load' },
        fmt([[
with open('{}', 'r') as f:
    {} = yaml.safe_load(f)
]],
            {
                i(1, 'file.yaml'),
                i(0, 'data'),
            }
        )
    ),

    s({ trig = 'itoml', dscr = 'Import toml' },
        t('import tomli')
    ),

    s({ trig = 'tomlcomp', dscr = 'toml.loads / toml.dumps' },
        fmt([[
toml.loads({})
toml.dumps({})
]],
            {
                i(1, 's'),
                i(0, 'obj'),
            }
        )
    ),

    ---------------------------------------
    -- 13. Type Hints
    ---------------------------------------

    s({ trig = 'typelist', dscr = 'List type hint' },
        fmt([[
list[{}]
]],
            {
                i(0, 'int'),
            }
        )
    ),

    s({ trig = 'typedict', dscr = 'Dict type hint' },
        fmt([[
dict[{}, {}]
]],
            {
                i(1, 'str'),
                i(0, 'int'),
            }
        )
    ),

    s({ trig = 'typetuple', dscr = 'Tuple type hint' },
        fmt([[
tuple[{}]
]],
            {
                i(0, 'int, str'),
            }
        )
    ),

    s({ trig = 'typeunion', dscr = 'Union type hint' },
        fmt([[
Union[{}, {}]
]],
            {
                i(1, 'int'),
                i(0, 'str'),
            }
        )
    ),

    s({ trig = 'typeopt', dscr = 'Optional type hint' },
        fmt([[
Optional[{}]
]],
            {
                i(0, 'int'),
            }
        )
    ),

    s({ trig = 'typecall', dscr = 'Callable type hint' },
        fmt([[
Callable[[{}], {}]
]],
            {
                i(1, 'int'),
                i(0, 'str'),
            }
        )
    ),

    s({ trig = 'typeany', dscr = 'Any type hint' },
        t('Any')
    ),

    s({ trig = 'typecast', dscr = 'cast function' },
        fmt([[
cast({}, {})
]],
            {
                i(1, 'int'),
                i(0, 'value'),
            }
        )
    ),

    s({ trig = 'typefinal', dscr = 'Final type hint' },
        fmt([[
from typing import Final

{}: Final = {}
]],
            {
                i(1, 'CONSTANT'),
                i(0, '42'),
            }
        )
    ),

    s({ trig = 'typenamed', dscr = 'NamedTuple' },
        fmt([[
from typing import NamedTuple

class {}(NamedTuple):
    {}

{}
]],
            {
                i(1, 'Point'),
                i(2, 'x: int'),
                i(3, 'y: int'),
            }
        )
    ),

    ---------------------------------------
    -- 14. Logging / Debugging
    ---------------------------------------

    s({ trig = 'ilog', dscr = 'Import logging' },
        t('import logging')
    ),

    s({ trig = 'logbasic', dscr = 'Logging basic config' },
        fmt([[
logging.basicConfig(
    level=logging.{},
    format='{}',
    handlers=[logging.FileHandler('{}'), logging.StreamHandler()]
)
logger = logging.getLogger(__name__)
]],
            {
                c(1, { t('DEBUG'), t('INFO'), t('WARNING'), t('ERROR') }),
                i(2, '%(asctime)s - %(name)s - %(levelname)s - %(message)s'),
                i(0, 'app.log'),
            }
        )
    ),

    s({ trig = 'logget', dscr = 'Get logger' },
        t("logger = logging.getLogger(__name__)")
    ),

    s({ trig = 'logdebug', dscr = 'Logging debug' },
        fmt([[
logger.debug({})
]],
            {
                i(0, '"message"'),
            }
        )
    ),

    s({ trig = 'loginfo', dscr = 'Logging info' },
        fmt([[
logger.info({})
]],
            {
                i(0, '"message"'),
            }
        )
    ),

    s({ trig = 'logwarn', dscr = 'Logging warning' },
        fmt([[
logger.warning({})
]],
            {
                i(0, '"message"'),
            }
        )
    ),

    s({ trig = 'logerror', dscr = 'Logging error' },
        fmt([[
logger.error({})
]],
            {
                i(0, '"message"'),
            }
        )
    ),

    s({ trig = 'logexc', dscr = 'Logging exception' },
        fmt([[
logger.exception({})
]],
            {
                i(0, '"message"'),
            }
        )
    ),

    s({ trig = 'itqdm', dscr = 'Import tqdm' },
        t('from tqdm import tqdm')
    ),

    s({ trig = 'tqdm', dscr = 'Tqdm progress bar' },
        fmt([[
for i in tqdm({}):
    {}
]],
            {
                i(1, 'range(100)'),
                i(0, 'pass'),
            }
        )
    ),

    s({ trig = 'tqdmwr', dscr = 'Tqdm wrapper' },
        fmt([[
from tqdm import tqdm

with tqdm(total={}) as pbar:
    for item in {}:
        pbar.update(1)
]],
            {
                i(1, 'len(items)'),
                i(0, 'items'),
            }
        )
    ),

    ---------------------------------------
    -- 15. DateTime
    ---------------------------------------

    s({ trig = 'idatetime', dscr = 'Import datetime' },
        t('from datetime import datetime, timedelta')
    ),

    s({ trig = 'datetime.now', dscr = 'Current datetime' },
        t("datetime.now()")
    ),

    s({ trig = 'datetime.strptime', dscr = 'Parse datetime string' },
        fmt([[
datetime.strptime({}, '{}')
]],
            {
                i(1, '2024-01-01'),
                i(0, '%Y-%m-%d'),
            }
        )
    ),

    s({ trig = 'datetime.strftime', dscr = 'Format datetime' },
        fmt([[
{}.strftime('{}')
]],
            {
                i(1, 'dt'),
                i(0, '%Y-%m-%d %H:%M:%S'),
            }
        )
    ),

    s({ trig = 'timedelta', dscr = 'Timedelta' },
        fmt([[
timedelta(days={}, hours={}, minutes={})
]],
            {
                i(1, '0'),
                i(2, '0'),
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'idateutil', dscr = 'Import dateutil' },
        t('from dateutil import parser')
    ),

    s({ trig = 'dateutilparse', dscr = 'dateutil parser' },
        fmt([[
parser.parse({})
]],
            {
                i(0, '"2024-01-01"'),
            }
        )
    ),

    ---------------------------------------
    -- 16. Collections / Utilities
    ---------------------------------------

    s({ trig = 'icollections', dscr = 'Import collections' },
        t('from collections import defaultdict, Counter, OrderedDict, deque')
    ),

    s({ trig = 'defaultdict', dscr = 'DefaultDict' },
        fmt([[
{} = defaultdict({})
{}
]],
            {
                i(1, 'd'),
                i(2, 'int'),
                i(0, "# d[key] will default to 0 if int"),
            }
        )
    ),

    s({ trig = 'counter', dscr = 'Counter' },
        fmt([[
Counter({})
]],
            {
                i(1, 'sequence'),
            }
        )
    ),

    s({ trig = 'deque', dscr = 'Deque' },
        fmt([[
deque([{}], maxlen={})
]],
            {
                i(1, 'items'),
                i(0, 'None'),
            }
        )
    ),

    s({ trig = 'ifunctools', dscr = 'Import functools' },
        t('from functools import lru_cache, wraps, partial')
    ),

    s({ trig = 'lrucache', dscr = 'LRU cache' },
        fmt([[
@lru_cache(maxsize={})
def {}({}):
    {}
]],
            {
                i(1, '128'),
                i(2, 'func'),
                i(3, 'arg'),
                i(0),
            }
        )
    ),

    s({ trig = 'functools.partial', dscr = 'Partial function' },
        fmt([[
{} = partial({}, {})
]],
            {
                i(1, 'new_func'),
                i(2, 'func'),
                i(0, 'arg'),
            }
        )
    ),

    s({ trig = 'iitertools', dscr = 'Import itertools' },
        t('import itertools')
    ),

    s({ trig = 'itertools.product', dscr = 'Itertools product' },
        fmt([[
itertools.product({}, {})
]],
            {
                i(1, 'range(3)'),
                i(0, 'range(3)'),
            }
        )
    ),

    s({ trig = 'itertools.permutations', dscr = 'Itertools permutations' },
        fmt([[
itertools.permutations({}, r={})
]],
            {
                i(1, 'iterable'),
                i(0, '2'),
            }
        )
    ),

    s({ trig = 'itertools.combinations', dscr = 'Itertools combinations' },
        fmt([[
itertools.combinations({}, r={})
]],
            {
                i(1, 'iterable'),
                i(0, '2'),
            }
        )
    ),

    s({ trig = 'iop', dscr = 'Import operator' },
        t('import operator')
    ),

    s({ trig = 'itemgetter', dscr = 'ItemGetter' },
        fmt([[
from operator import itemgetter
sorted({}, key=itemgetter({}))
]],
            {
                i(1, 'data'),
                i(0, '0'),
            }
        )
    ),

    s({ trig = 'attrgetter', dscr = 'AttrGetter' },
        fmt([[
from operator import attrgetter
sorted({}, key=attrgetter('{}'))
]],
            {
                i(1, 'objects'),
                i(0, 'name'),
            }
        )
    ),

    ---------------------------------------
    -- 17. Math / Statistics
    ---------------------------------------

    s({ trig = 'imath', dscr = 'Import math' },
        t('import math')
    ),

    s({ trig = 'mathfunc', dscr = 'Math functions' },
        fmt([[
math.sqrt({})
math.pow({}, {})
math.log({}, {})
math.sin({})
math.cos({})
math.floor({})
math.ceil({})
]],
            {
                i(1, 'x'),
                i(2, 'x'),
                i(3, '2'),
                i(4, 'x'),
                i(5, 'e'),
                i(6, 'x'),
                i(7, 'x'),
                i(8, 'x'),
                i(9, 'x'),
            }
        )
    ),

    s({ trig = 'istats', dscr = 'Import statistics' },
        t('import statistics')
    ),

    s({ trig = 'statsfunc', dscr = 'Statistics functions' },
        fmt([[
statistics.mean({})
statistics.median({})
statistics.mode({})
statistics.stdev({})
statistics.variance({})
]],
            {
                i(0, 'data'),
                i(1, 'data'),
                i(2, 'data'),
                i(3, 'data'),
                i(4, 'data'),
            }
        )
    ),

    s({ trig = 'irandom', dscr = 'Import random' },
        t('import random')
    ),

    s({ trig = 'randomfunc', dscr = 'Random functions' },
        fmt([[
random.random()
random.randint({}, {})
random.choice({})
random.choices({}, k={})
random.shuffle({})
random.sample({}, k={})
]],
            {
                i(1, '0'),
                i(2, '10'),
                i(3, 'sequence'),
                i(4, 'sequence'),
                i(5, '3'),
                i(6, 'sequence'),
                i(7, 'sequence'),
                i(8, '3'),
            }
        )
    ),

    s({ trig = 'ihashlib', dscr = 'Import hashlib' },
        t('import hashlib')
    ),

    s({ trig = 'hashlib', dscr = 'Hashlib functions' },
        fmt([[
hashlib.md5({}).hexdigest()
hashlib.sha1({}).hexdigest()
hashlib.sha256({}).hexdigest()
hashlib.sha512({}).hexdigest()
]],
            {
                i(0, 'b"data"'),
                i(1, 'b"data"'),
                i(2, 'b"data"'),
                i(3, 'b"data"'),
            }
        )
    ),

    s({ trig = 'base64', dscr = 'Base64 encode/decode' },
        fmt([[
import base64

encoded = base64.b64encode({}).decode()
decoded = base64.b64decode({}).decode()
]],
            {
                i(1, 'b"data"'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 18. Path / Glob
    ---------------------------------------

    s({ trig = 'ipathlib', dscr = 'Import pathlib' },
        t('from pathlib import Path')
    ),

    s({ trig = 'path', dscr = 'Path creation' },
        fmt([[
Path('{}')
]],
            {
                i(0, '/path/to/file'),
            }
        )
    ),

    s({ trig = 'pathglob', dscr = 'Path glob' },
        fmt([[
list(Path('{}').glob('{}'))
]],
            {
                i(1, '.'),
                i(0, '*.py'),
            }
        )
    ),

    s({ trig = 'pathrglob', dscr = 'Path rglob (recursive)' },
        fmt([[
list(Path('{}').rglob('{}'))
]],
            {
                i(1, '.'),
                i(0, '*.py'),
            }
        )
    ),

    s({ trig = 'pathread', dscr = 'Path read/write text' },
        fmt([[
Path('{}').read_text()
Path('{}').write_text({})
]],
            {
                i(1, 'file.txt'),
                i(2, 'file.txt'),
                i(0, 'content'),
            }
        )
    ),

    s({ trig = 'iglob', dscr = 'Import glob' },
        t('import glob')
    ),

    s({ trig = 'glob', dscr = 'Glob files' },
        fmt([[
glob.glob('{}')
glob.iglob('{}')
]],
            {
                i(1, '*.py'),
                i(0),
            }
        )
    ),

    ---------------------------------------
    -- 19. functools / functools
    ---------------------------------------

    s({ trig = 'reduce', dscr = 'Reduce function' },
        fmt([[
from functools import reduce
reduce(lambda {}, {}: {}, {})
]],
            {
                i(1, 'acc'),
                i(2, 'curr'),
                i(3, 'acc + curr'),
                i(0, 'iterable'),
            })
    ),

    s({ trig = 'cmp', dscr = 'Cmp_to_key' },
        fmt([[
from functools import cmp_to_key

def cmp(a, b):
    return (a > b) - (a < b)

sorted({}, key=cmp_to_key(cmp))
]],
            {
                i(0, 'data'),
            }
        )
    ),

    ---------------------------------------
    -- 20. dataclasses / attrs
    ---------------------------------------

    s({ trig = 'dataclass', dscr = 'Dataclass with fields' },
        fmt([[
from dataclasses import dataclass, field
from typing import {}

@dataclass
class {}:
    {}: {}
    {}: {} = field(default={})
]],
            {
                i(1, 'List'),
                i(2, 'MyClass'),
                i(3, 'name'),
                i(4, 'str'),
                i(5, 'items'),
                i(6, 'List[str]'),
                i(0, 'default_factory=list'),
            }
        )
    ),

    s({ trig = 'dataclassfield', dscr = 'Dataclass field' },
        fmt([[
field(default={}, compare={})
]],
            {
                i(1, 'None'),
                i(0, 'False'),
            }
        )
    ),

    s({ trig = 'iattrs', dscr = 'Import attrs' },
        t('import attr')
    ),

    s({ trig = 'attrcls', dscr = 'Attrs class' },
        fmt([[
@attr.s
class {}:
    {} = attr.ib()
    {} = attr.ib(default={})
]],
            {
                i(1, 'MyClass'),
                i(2, 'name'),
                i(3, 'items'),
                i(0, '[]'),
            }
        )
    ),
}
