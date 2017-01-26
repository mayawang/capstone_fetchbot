import { ContentStore } from './content-store';
import { Content } from './content.component';
import { addContentAction, skipAction} from './actions';
import { ContentService } from './content-service';
import {
  Component,
  trigger,
  state,
  style,
  transition,
  animate
} from '@angular/core';

@Component({
  selector: 'content-list',
  templateUrl: 'app/content-list.html',
  providers: [],
  styleUrls: ['app/content-list.css'],
  // directives: [Content]
  animations: [
    trigger('slideInOut', [
      state('in', style({
        transform: 'translate3d(0,0,-30px)'
      })),
      transition('void => *', [
        style({transform: 'translate3d(-100%,0,0)'}),
        animate(400)
      ]),
      transition('* => void', [
        animate(400, style({transform: 'translateX(100%)'}))
      ])
    ])
  ],
})

export class ContentList {

	constructor(private contentService: ContentService) {
	}

  addContentHandler(query) {
    this.contentService.clearAllContents();

    this.contentService.getContent(query).subscribe(resp => {
      // console.log(resp)
      let items = resp.items;

      for (let item of items) {
        this.contentService.addContent(item);
      }
    },err => {
      // Log errors if any
      console.log(err);
    })
  }

  changeUserHandler(userId) {
    this.contentService.setUserId(userId);
  }
}
