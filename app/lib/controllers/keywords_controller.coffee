@KeywordsController = RouteController.extend(
  layoutTemplate: "SimpleLayout"
  waitOn: -> []
  action: ->
    @render "Keywords"
)
