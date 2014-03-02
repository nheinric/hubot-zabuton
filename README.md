# Zabuton (座布団)

[Hubot](https://github.com/github/hubot) plugin that allows you to give and remove zabuton (座布団) from a given user.

This plugin won't make much sense to you unless you've seen the TV show Shōten ([Japanese link](https://ja.wikipedia.org/wiki/%E7%AC%91%E7%82%B9), [English link](https://en.wikipedia.org/wiki/Sh%C5%8Dten)).

# Commands:
## English:
* hubot give `number` zabuton to `username` - award `number` zabuton to `username`
* hubot give `username` `number` zabuton - award `number` zabuton to `username`
* hubot take `number` zabuton from `username` - take away `number` zabuton from `username`
* hubot how many zabuton does `username` have? - list how many zabuton `username` has
* hubot take all zabuton from `username` - removes all zabuton from `username`

## Japanese:
* '座布団' can be in kanji, hiragana or katakana: (座布団|ざぶとん|ザブトン)
* You may suffix the commands with any text you like
* e.g., nateの座布団全部取っちまえ！

* hubot `username`に座布団`number`枚 - award `number` zabuton to `username`
* hubot `username`(から|の)座布団`number`枚 - take away `number` zabuton from `username`
* hubot `username`(、|\s)?(寒い|さむい|サムイ|さみー) - take away 1 zabuton from `username`
* hubot `username`は?座布団何枚 - list how many zabuton `username` has
* hubot `username`(から|の)座布団全部 - removes all zabuton from `username`

# Attribution

This plugin was based heavily on brettlangdon's [points plugin](https://github.com/github/hubot-scripts/blob/master/src/scripts/points.coffee).

# License

Copyright (c) 2014 Nathaniel Heinrichs

This package is released under [The MIT License (MIT)](http://opensource.org/licenses/MIT)
