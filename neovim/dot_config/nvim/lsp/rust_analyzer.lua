return {
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      cargo = {
        buildScripts = {
          nJobs = 4,
        },
      },
      analysis = {
        nJobs = 4,
      },
      procMacro = {
        server = {
          numThreads = 4,
        },
      },
    },
  },
}
