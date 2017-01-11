import { Content as ContentModel} from './content-store';
// import { getContent } from './content-service';

export interface IContentAction {
  type: string;
  id: number;
  title?: string;
  summary?: string;
  link?: string;
}

export function addContent( link: string, title: string, id: number, summary: string ): IContentAction {
  return {
    type: 'ADD',
    id,
    title,
    summary,
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
    id,
  };
}
