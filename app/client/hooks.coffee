AutoForm.addHooks null,
  onError: (name, error, template) ->
    console.error name + " error:", error

hooks =
  userKeywords:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc
  activePlayfield:
    onSubmit: (insertDoc, updateDoc, currentDoc) ->
      this.event.preventDefault()
      Session.set("activePlayfield", insertDoc.playfieldId)
      false
  team:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        console.log("doc", doc)
        doc
    onSuccess: (formType, result) ->
      console.log("onSuccess")
      Router.go("Teams")

AutoForm.hooks
  userKeywords: hooks.userKeywords
  activePlayfield: hooks.activePlayfield
  teamNew: hooks.team
