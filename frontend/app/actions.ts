import { Content as ContentModel} from './content-store';

export interface IContentAction {
  type: string;
  id: number;
  title?: string;
}

export function addContent(title: string, id: number): IContentAction {
  return {
    type: 'ADD',
    id,
    title
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
