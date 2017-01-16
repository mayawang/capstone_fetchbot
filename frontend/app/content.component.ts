import { Component, Input, ChangeDetectionStrategy} from '@angular/core';
import { ContentStore, Content as ContentModel} from './content-store';
import { dislikeAction, likeAction } from './actions';
import { ContentService } from './content-service';

@Component({
  selector: 'content',
  templateUrl: 'app/content.html',
  styleUrls: ['app/content.css'],
  providers: [ ContentService],
  changeDetection: ChangeDetectionStrategy.OnPush
})

export class Content {
  @Input()
  content: ContentModel;

  constructor(private store: ContentStore, private contentService: ContentService) { }

  likeHandler(content) {
    this.store.dispatch(likeAction(content.id));
    this.contentService.likeContent(content.id).subscribe(resp => {},err => {
      // Log errors if any
      console.log(err);
    })
  }

  dislikeHandler(content) {
    this.store.dispatch(dislikeAction(content.id));
    this.contentService.dislikeContent(content.id).subscribe(resp => {},err => {
      // Log errors if any
      console.log(err);
    })
  }

  clickHandler(content) {
    this.contentService.clickContent(content.id).subscribe(resp => {},err => {
      // Log errors if any
      console.log(err);
    })
  }
}
