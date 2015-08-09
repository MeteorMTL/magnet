Likes.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fieldNames, modifier) ->
    false
  remove: (userId, doc) ->
    false

Likes.deny
  insert: (userId, doc) ->
    false
  update: (userId, doc, fieldNames, modifier) ->
    true
  remove: (userId, doc) ->
    false
