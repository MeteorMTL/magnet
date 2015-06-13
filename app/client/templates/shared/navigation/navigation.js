/*****************************************************************************/
/* Navigation: Event Handlers */
/*****************************************************************************/
Template.Navigation.events({
  'click #at-nav-button': function(event) {
    if (Meteor.user()) {
      AccountsTemplates.logout();
    } else {
      Router.go('login');
    }
  }
});

/*****************************************************************************/
/* Navigation: Helpers */
/*****************************************************************************/
Template.Navigation.helpers({
});

/*****************************************************************************/
/* Navigation: Lifecycle Hooks */
/*****************************************************************************/
Template.Navigation.created = function () {
};

Template.Navigation.rendered = function () {
  $('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
  });
};

Template.Navigation.destroyed = function () {
};
