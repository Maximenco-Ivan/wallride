import * as riot from 'riot';
import route from 'riot-route'
import $ from 'jquery';
import 'bootstrap';
import 'select2';
import 'froala-editor';
import 'blueimp/jQuery-File-Upload';
import 'nylen/shiftcheckbox';
import 'ilikenwf/nestedSortable';
import 'xdan/datetimepicker';
import 'moment/moment';

import 'wallride/tag/app.tag!';
import 'wallride/tag/login.tag!';
import 'wallride/tag/home.tag!';
import 'wallride/tag/nav-global.tag!';
import 'wallride/tag/nav-blog.tag!';
import 'wallride/tag/dashboard.tag!';
import 'wallride/tag/article/index.tag!';
import 'wallride/tag/article/create.tag!';
import 'wallride/tag/article/edit.tag!';
import 'wallride/tag/article/describe.tag!';
import 'wallride/tag/page/index.tag!';
import 'wallride/tag/page/create.tag!';
import 'wallride/tag/page/edit.tag!';
import 'wallride/tag/page/describe.tag!';
import 'wallride/tag/page/tree.tag!';
import 'wallride/tag/category/index.tag!';
import 'wallride/tag/tag/index.tag!';
import 'wallride/tag/customfield/index.tag!';
// import 'wallride/tag/customfield/create.tag!';
import 'wallride/tag/customfield/edit.tag!';
import 'wallride/tag/comment/index.tag!';
import 'wallride/tag/user/index.tag!';
import 'wallride/tag/user/edit.tag!';
import 'wallride/tag/user/describe.tag!';
import 'wallride/tag/user/invitation/index.tag!';
import 'wallride/tag/analytics/index.tag!';
import 'wallride/tag/analytics/edit.tag!';
import 'wallride/tag/system/index.tag!';
import 'wallride/tag/signup/signup.tag!';
import 'wallride/tag/froala.tag!';
import 'wallride/tag/setup.tag!';

import 'wallride/tag/post-status-select2.tag!';

import 'wallride/css/admin.css!';

route.base('/_admin/');

let subRoute;
subRoute = route.create();
subRoute('login', () => {
    riot.mount('#app', 'login');
});
subRoute('', () => {
    riot.mount('#app', 'home');
});

subRoute = route.create();
subRoute('', () => {
    riot.mount('#wr-page', 'dashboard');
});
subRoute('articles', () => {
    riot.mount('#wr-page', 'article-index');
});
subRoute('articles/new', () => {
    riot.mount('#wr-page', 'article-create');
});
subRoute('articles/*', () => {
    riot.mount('#wr-page', 'article-describe');
});
subRoute('articles/*/edit', () => {
    riot.mount('#wr-page', 'article-edit');
});
subRoute('pages', () => {
    riot.mount('#wr-page', 'page-index');
});
subRoute('pages/tree', () => {
    riot.mount('#wr-page', 'page-tree');
});
subRoute('pages/new', () => {
    riot.mount('#wr-page', 'page-create');
});
subRoute('pages/*', () => {
    riot.mount('#wr-page', 'page-describe');
});
subRoute('pages/*/edit', () => {
    riot.mount('#wr-page', 'page-edit');
});
subRoute('categories', () => {
    riot.mount('#wr-page', 'category-index');
});
subRoute('tags', () => {
    riot.mount('#wr-page', 'tag-index');
});
subRoute('customfields', () => {
    riot.mount('#wr-page', 'customfield-index');
});
subRoute('customfields/new', () => {
    riot.mount('#wr-page', 'customfield-create');
});
subRoute('customfields*/edit', () => {
    riot.mount('#wr-page', 'customfield-edit');
});
subRoute('comments', () => {
    riot.mount('#wr-page', 'comment-index');
});
subRoute('users', () => {
    riot.mount('#wr-page', 'user-index');
});
subRoute('users/invite', () => {
    riot.mount('#wr-page', 'user-invitation');
});
subRoute('users/*', () => {
    riot.mount('#wr-page', 'user-describe');
});
subRoute('users/*/edit', () => {
    riot.mount('#wr-page', 'user-edit');
});
subRoute('analytics', () => {
    riot.mount('#wr-page', 'analytics-index');
});
subRoute('analytics/edit', () => {
    riot.mount('#wr-page', 'analytics-edit');
});
subRoute('system', () => {
    riot.mount('#wr-page', 'system-index');
});
subRoute('setup', () => {
    riot.mount('#wr-page', 'setup');
});
subRoute('signup', () => {
    riot.mount('#wr-page', 'signup');
});

riot.mount('app', {title:"Hello, JSPM and Riot!"});
route.start(true);
