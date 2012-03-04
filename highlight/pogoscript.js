/*
Language: Pogoscript
*/
exports.pogoscript = function(hljs) {
  return {
    defaultMode: {
      keywords: {
        'keyword': {'if': 1, 'else': 1, 'for': 1, 'do': 1, 'while': 1, 'self': 1},
        'literal': {'true': 1, 'false': 1, 'null': 1}
      },
      contains: [
        hljs.APOS_STRING_MODE,
        hljs.QUOTE_STRING_MODE,
        hljs.C_NUMBER_MODE
      ]
    }
  };
}