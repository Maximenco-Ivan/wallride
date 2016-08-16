import riot from 'riot';
import $ from 'jquery';
// import bootstrap from 'bootstrap';
// import upload from 'jquery-file-upload';
// import froala from 'froala-editor';
// import select2 from 'select2';

import 'tags/app.tag!';
import 'tags/login.tag!';
import 'tags/home.tag!';
import 'tags/nav-global.tag!';
import 'tags/nav-blog.tag!';
import 'tags/dashboard.tag!';
import 'tags/article-index.tag!';
import 'tags/page-index.tag!';

riot.mixin('$', { $ });

riot.route.base('/html/');

// var route = riot.route.create();
// riot.route('login', () => {
// 	riot.mount('#app', 'login');
// });
// riot.route('/', () => {
// 	riot.mount('#app', 'home');
// });
// riot.route('*', () => {
// 	riot.mount('#app', 'home');
// });

riot.mount('app', {title:"Hello, JSPM and Riot!"});

riot.route.start(true);



