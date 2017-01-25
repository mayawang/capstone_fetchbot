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
    case 'SKIP':
      return state.delete(findIndexById());
    case 'DISLIKE':
      return state.delete(findIndexById());
    case 'LIKE':
      // return state.delete(findIndexById());
      return state.update(findIndexById(), (value) => {
        return {...value, like: true};
      });
    case 'DELETE':
      return state.delete(findIndexById());

    default:
      return state;
  }

  function findIndexById() {
    return state.findIndex((content) => content.id === action.id);
  }
}
