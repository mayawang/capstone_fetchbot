import { Content as ContentModel} from './content-store';

export interface IContentAction {
  type: string;
  id: number;
  name?: string;
}

export function addContent(name: string, id: number): IContentAction {
  return {
    type: 'ADD',
    id,
    name
  };
}

export function removeContent(id: number): IContentAction {
  return {
    type: 'REMOVE',
    id
  };
}

export function likeContent(id: number): IContentAction {
  return {
    type: 'LIKE',
    id
  };
}
