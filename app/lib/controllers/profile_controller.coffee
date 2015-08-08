@ProfileController = RouteController.extend(
  subscriptions: ->
    @subscribe("ProfilePhoto").wait()
  data: ->
  action: ->
    @render "Profile", {}
)
