local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local f = ls.function_node

-- Lorem ipsum words
local lorem_words = {
  "lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
  "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore",
  "magna", "aliqua", "enim", "ad", "minim", "veniam", "quis", "nostrud",
  "exercitation", "ullamco", "laboris", "nisi", "aliquip", "ex", "ea", "commodo",
  "consequat", "duis", "aute", "irure", "in", "reprehenderit", "voluptate",
  "velit", "esse", "cillum", "fugiat", "nulla", "pariatur", "excepteur", "sint",
  "occaecat", "cupidatat", "non", "proident", "sunt", "culpa", "qui", "officia",
  "deserunt", "mollit", "anim", "id", "est", "laborum"
}

local function generate_lorem_words(count)
  local words = {}
  math.randomseed(os.time())
  
  for i = 1, count do
    table.insert(words, lorem_words[math.random(#lorem_words)])
  end
  
  local text = table.concat(words, " ")
  return text:sub(1,1):upper() .. text:sub(2) .. "."
end

-- Dynamic lorem snippet that captures number from trigger
ls.add_snippets("all", {
  s({
    trig = "lorem(%d+)",
    regTrig = true,
    name = "Lorem ipsum with custom word count",
    dscr = "Generate lorem ipsum with specified word count (e.g., lorem40)"
  }, {
    f(function(_, snip)
      local word_count = tonumber(snip.trigger:match("(%d+)")) or 10
      return generate_lorem_words(word_count)
    end, {})
  }),
  
  -- Default lorem (20 words)
  s("lorem", {
    f(function() return generate_lorem_words(20) end, {})
  }),
})