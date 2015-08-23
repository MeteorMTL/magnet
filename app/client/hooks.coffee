AutoForm.addHooks null,
  onError: (name, error, template) ->
    console.error name + " error:", error

hooks =
  userKeywords:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc

AutoForm.hooks
  userKeywords: hooks.userKeywords
