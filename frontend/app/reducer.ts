import Immutable = require('immutable');
import { IContentAction } from './actions';
import { Content as ContentModel} from './content-store';

export function reducer(state: Immutable.List<ContentModel> = Immutable.List<ContentModel>(), action: IContentAction) {
  switch (action.type) {
    case 'ADD':
      return state.push({
        id: action.id,
        title: action.title,
        like: false,
        summary: action.summary,
        link: action.link
      });
    case 'REMOVE':
      return state.delete(findIndexById());
    case 'LIKE':
      return (<any>state).update(findIndexById(), (content) => {
        return {
          id: content.id,
          title: content.title,
          like: !content.like,
          summary: content.summary,
          link: content.link,
        };
      });
    default:
      return state;
  }

  function findIndexById() {
    return state.findIndex((content) => content.id === action.id);
  }
}
