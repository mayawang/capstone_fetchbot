
import { Component, Input, ChangeDetectionStrategy} from '@angular/core';
// import { contentStore, content as contentModel} from './content-store';
// import { removecontent, starcontent } from './actions';

@Component({
  selector: 'content',
  templateUrl: 'app/content.html',
  styleUrls: ['app/content.css'],
  changeDetection: ChangeDetectionStrategy.OnPush
})

export class Content {
  // @Input()
  // content: ContentModel;

  // constructor(private store: ContentStore) { }
  //
  // removeContent(content) {
  //   this.store.dispatch(removeContent(content.id));
  // }
  //
  // starcontent(content) {
  //   this.store.dispatch(starContent(content.id));
  // }
}
