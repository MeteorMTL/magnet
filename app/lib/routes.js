Router.configure({
  layoutTemplate: 'MasterLayout',
  loadingTemplate: 'Loading',
  notFoundTemplate: 'NotFound'
});

Router.route('/', {
  name: 'home',
  controller: 'HomeController',
  action: 'action',
  where: 'client'
});


Router.route('votes', {
  name: 'votes',
  controller: 'VotesController',
  action: 'action',
  where: 'client'
});

Router.route('topics', {
  name: 'topics',
  controller: 'TopicsController',
  action: 'action',
  where: 'client'
});

Router.route('photos', {
  name: 'photos',
  controller: 'PhotosController',
  action: 'action',
  where: 'client'
});