local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
    s({ trig = "mainapp", dscr = "Creates main function and basic MyApp (StatelessWidget)" },
        fmt([[
        import 'package:flutter/material.dart';

        void main() {{
          runApp(const MyApp());
        }}

        class MyApp extends StatelessWidget {{
          const MyApp({{super.key}});

          @override
          Widget build(BuildContext context) {{
            return MaterialApp(
              title: '{}',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const {}
            );
          }}
        }}
        ]],
            {
                i(1, "Flutter Demo"),
                i(2, "MyHomePage()"),
            }
        )
    ),

    s({ trig = "stateless", dscr = "Creates a StatelessWidget template" },
        fmt([[
        class {} extends StatelessWidget {{
          const {}({{super.key}});

          @override
          Widget build(BuildContext context) {{
            return {};
          }}
        }}
        ]],
            {
                i(1, "MyWidget"),
                i(2, "MyWidget"),
                i(3),
            }
        )
    ),

    s({ trig = "stateful", dscr = "Creates a StatefulWidget template" },
        fmt([[
        class {} extends StatefulWidget {{
          const {}({{super.key}});

          @override
          State<{}> createState() => _{}State();
        }}

        class _{}State extends State<{}> {{
          @override
          Widget build(BuildContext context) {{
            return {};
          }}
        }}
        ]],
            {
                i(1, "MyStatefulWidget"),
                i(2, "MyStatefulWidget"),
                i(3, "MyStatefulWidget"),
                i(4, "MyStatefulWidget"),
                i(5, "MyStatefulWidget"),
                i(6, "MyStatefulWidget"),
                i(7),
            }
        )
    ),

    s({ trig = "scaffold", dscr = "Creates a basic Scaffold structure" },
        fmt([[
        Scaffold(
          appBar: AppBar(
            title: const Text('{}'),
          ),
          body: Center(
            child: {}
          ),
          floatingActionButton: {}
        )
        ]],
            {
                i(1, "Title"),
                i(2, "Text('Hello')"),
                i(3),
            }
        )
    ),

    s({ trig = "print", dscr = "Shortcut for print statement" },
        fmt([[
        print('{}');
        ]],
            {
                i(1),
            }
        )
    ),

    s({ trig = "con", dscr = "Generates const constructor" },
        fmt([[
        const {}({{super.key}});
        ]],
            {
                i(1, "WidgetName"),
            }
        )
    ),

    s({ trig = "sizedbox", dscr = "Generates SizedBox with height/width" },
        fmt([[
        SizedBox({}: {}, {}: {}),
        ]],
            {
                i(1, "height"),
                i(2),
                i(3, "width"),
                i(4),
            }
        )
    ),

    s({ trig = "column", dscr = "Generates Column with children" },
        fmt([[
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            {}
            ],
        )
        ]],
            {
                i(1),
            }
        )
    ),

    s({ trig = "row", dscr = "Generates Row with children" },
        fmt([[
        Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            {}
            ],
        )
        ]],
            {
                i(1),
            }
        )
    ),

    s({ trig = "listview", dscr = "Generates ListView with children" },
        fmt([[
        ListView(
          children: [
            {}
          ],
        )
        ]],
            {
                i(1),
            }
        )
    ),

    s({ trig = "mediaquery", dscr = "Accesses MediaQuery.of(context).size.xxx" },
        fmt([[
        MediaQuery.of(context).size.{}
        ]],
            {
                i(1, "width/height"),
            }
        )
    ),

    s({ trig = "initstate", dscr = "Generates initState method" },
        fmt([[
        @override
        void initState() {{
          super.initState();
          {}
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    s({ trig = "dispose", dscr = "Generates dispose method" },
        fmt([[
        @override
        void dispose() {{
          {}
          super.dispose();
        }}
        ]],
            {
                i(1),
            }
        )
    ),

    s({ trig = "getx", dscr = "GetX Controller binding Get.put()" },
        fmt([[
        Get.put({}())
        ]],
            {
                i(1, "ControllerName"),
            }
        )
    ),
}
