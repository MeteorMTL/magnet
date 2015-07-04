ProfileController = RouteController.extend({
  subscriptions: function () {
    this.subscribe('ProfilePhoto').wait();
  },
  data: function () {
  },
  action: function () {
    this.render('Profile', {});
  }
});
