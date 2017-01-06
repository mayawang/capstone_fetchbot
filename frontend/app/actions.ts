import { Content as ContentModel} from './content-store';
// import { getContent } from './content-service';

export interface IContentAction {
  type: string;
  id: number;
  title?: string;
  desc?: string;
  link?: string;
}

export function addContent( link: string, title: string, id: number, desc: string ): IContentAction {
  return {
    type: 'ADD',
    id,
    title,
    desc,
    link,
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
