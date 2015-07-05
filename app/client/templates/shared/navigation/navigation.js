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
  myName: function (){
    // if a user exists use the profile name, if that is no good use the email if all fails use 'who'
    return Meteor.user() ? 
             Meteor.user().profile.name ? 
	       Meteor.user().profile.name : 
	         Meteor.user().emails[0].address ?
	           Meteor.user().emails[0].address : "who"
	   : "who";
  }
});

/*****************************************************************************/
/* Navigation: Lifecycle Hooks */
/*****************************************************************************/
Template.Navigation.created = function () {
};

Template.Navigation.rendered = function () {
  $(".button-collapse").sideNav({
    menuWidth: 300,
    edge: "left",
    closeOnClick: true
  });
};

Template.Navigation.destroyed = function () {
};
