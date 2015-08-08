@TopicEditController = RouteController.extend(
  waitOn: -> [
      Meteor.subscribe("Topic", @params._id)
    ]
  data: ->
    Topics.findOne _id: @params._id
  action: ->
    @render "TopicEdit", {}
)
