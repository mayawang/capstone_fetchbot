
import { Component, Input, ChangeDetectionStrategy} from '@angular/core';
import { ContentStore, Content as ContentModel} from './content-store';
import { removeContent, likeContent } from './actions';

@Component({
  selector: 'content',
  templateUrl: 'app/content.html',
  styleUrls: ['app/content.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})

export class Content {
  @Input()
  content: ContentModel;

  constructor(private store: ContentStore) { }

  removeContent(content) {
    this.store.dispatch(removeContent(content.id));
  }

  likeContent(content) {
    this.store.dispatch(likeContent(content.id));
  }
}
