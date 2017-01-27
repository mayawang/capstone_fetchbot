import { ContentStore, Content as ContentModel} from './content-store';
import { dislikeAction, likeAction, addContentAction, deleteContentAction} from './actions';
import { ContentService } from './content-service';
import {
  Component,
  Input,
  ChangeDetectionStrategy,
  trigger,
  state,
  style,
  transition,
  animate
} from '@angular/core';

@Component({
  selector: 'content',
  templateUrl: 'app/content.html',
  styleUrls: ['app/content.css'],
  providers: [],
  changeDetection: ChangeDetectionStrategy.OnPush,
})

export class Content {
  @Input()
  content: ContentModel;

  constructor(private contentService: ContentService) { }

  // mock userId for now
  // userId = '6934';

  likeHandler(content) {
    var likedContentId = content.id;
    this.contentService.likeContentById(likedContentId);
    var contentIndex = this.contentService.findIndexById(content.id);

    var expectedAnimationTime = (new Date().getTime()) + 500;

    this.contentService.likeContent(likedContentId).subscribe(resp => {
      var currentTime = new Date().getTime();
      var delay = expectedAnimationTime - currentTime;
      if (delay < 0) {
        delay  = 0;
      }

      setTimeout(() => {
        this.contentService.deleteContentById(likedContentId);

        setTimeout(() => {
          this.contentService.addOneNonRepeatingContentAt(resp.items, contentIndex);
        }, 400);
      }, delay);
    },err => {
      // Log errors if any
      console.log(err);
    })
  }

  dislikeHandler(content) {
    var contentIndex = this.contentService.findIndexById(content.id);
    this.contentService.deleteContentById(content.id);
    this.contentService.dislikeContent(content.id).subscribe(resp => {
      // console.log(resp)
      this.contentService.addOneNonRepeatingContentAt(resp.items, contentIndex);
    },err => {
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
