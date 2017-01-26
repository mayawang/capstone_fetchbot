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
    this.contentService.likeContentById(likedContentId)

    setTimeout(() => {
      this.contentService.deleteContentById(likedContentId);
      this.contentService.likeContent(likedContentId).subscribe(resp => {
        // console.log(resp)
        this.contentService.addOneNonRepeatingContent(resp.items);
      },err => {
        // Log errors if any
        console.log(err);
      })
    }, 1500 );
  }

  dislikeHandler(content) {
    this.contentService.deleteContentById(content.id);
    this.contentService.dislikeContent(content.id).subscribe(resp => {
      // console.log(resp)
      this.contentService.addOneNonRepeatingContent(resp.items);
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
