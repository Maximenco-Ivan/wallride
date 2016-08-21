import riot from 'riot';
import $ from 'jquery';
import 'bootstrap';
import 'select2';
// import upload from 'jquery-file-upload';
// import froala from 'froala-editor';


import 'tags/app.tag!';
import 'tags/login.tag!';
import 'tags/home.tag!';
import 'tags/nav-global.tag!';
import 'tags/nav-blog.tag!';
import 'tags/dashboard.tag!';
import 'tags/article-index.tag!';
import 'tags/page-index.tag!';
import 'tags/category/index.tag!';

import 'tags/post-status-select2.tag!';

riot.route.base('/html/');
riot.mount('app', {title:"Hello, JSPM and Riot!"});
riot.route.start(true);
