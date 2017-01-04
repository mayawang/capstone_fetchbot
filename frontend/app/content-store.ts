import Immutable = require('immutable');
import { createStore } from 'redux';
import { IContentAction } from './actions';
import { reducer } from './reducer';

export class Content {
  id: number;
  name: String;
  star: boolean;
}

export class ContentStore {
  store = createStore(reducer, Immutable.List<Content>());

  get contents(): Immutable.List<Content> {
    return this.store.getState();
  }

  dispatch(action: IContentAction) {
    this.store.dispatch(action);
  }
}