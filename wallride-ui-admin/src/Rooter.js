import React from 'react';
import {BrowserRouter, Switch, Route} from 'react-router-dom';

import Root from './component/Root';
import Home from './component/Home';
import About from './component/About';
import User from './component/User';
import NotFound from './component/NotFound';

const Rooter = () => (
    <BrowserRouter>
        <div>
            <Route>
                <Switch>
                    <Route exact path="/" component={Root}/>
                    <Route path="/home" component={Home}/>
                    <Route path="/about" component={About}/>
                    <Route path="/user" component={User}/>
                    <Route path="/*" component={NotFound}/>
                </Switch>
            </Route>
        </div>
    </BrowserRouter>
);

export default Rooter;