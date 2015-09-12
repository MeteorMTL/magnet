AutoForm.addHooks null,
  onError: (name, error, template) ->
    console.error name + " error:", error

AutoForm.hooks
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
  teamNew:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc
    onSuccess: (formType, result) ->
      Router.go("Teams")
  newKeyword:
    before:
      insert: (doc) ->
        doc.authorId ?= Meteor.userId()
        doc
