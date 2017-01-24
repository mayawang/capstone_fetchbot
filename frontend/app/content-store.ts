import Immutable = require('immutable');
import { createStore, applyMiddleware } from 'redux';
import { IContentAction } from './actions';
import { reducer } from './reducer';
// import { composeWithDevTools } from 'redux-devtools-extension';

export class Content {
  id: number;
  title: String;
  like: boolean;
  summary: String;
  link: String;
}

// const store = createStore(reducer, composeWithDevTools(
//     applyMiddleware(...middleware),
//     // other store enhancers if any
//   ));
//
// const composeEnhancers = composeWithDevTools({
// // Specify here name, actionsBlacklist, actionsCreators and other options
// });
 // composeEnhancers(
export class ContentStore {
  store = createStore(reducer,
    Immutable.List<Content>()
  );


  get contents(): Immutable.List<Content> {
    return this.store.getState();
  }

  dispatch(action: IContentAction) {
    this.store.dispatch(action);
  }
}
