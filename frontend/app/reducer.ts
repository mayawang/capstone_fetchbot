import Immutable = require('immutable');
import { IContentAction } from './actions';
import { Content as ContentModel} from './content-store';

export function reducer(state: Immutable.List<ContentModel> = Immutable.List<ContentModel>(), action: IContentAction) {
  switch (action.type) {
    case 'ADD':
      return state.push({
        id: action.id,
        name: action.name,
        star: false
      });
    case 'REMOVE':
      return state.delete(findIndexById());
    case 'STAR':
      return (<any>state).update(findIndexById(), (content) => {
        return {
          id: content.id,
          name: content.name,
          star: !content.star
        };
      });
    default:
      return state;
  }

  function findIndexById() {
    return state.findIndex((content) => content.id === action.id);
  }
}
