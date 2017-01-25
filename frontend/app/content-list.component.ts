import { ContentStore } from './content-store';
import { Content } from './content.component';
import { addContentAction, skipAction} from './actions';
import { ContentService } from './content-service';
import {
  Component,
} from '@angular/core';

@Component({
  selector: 'content-list',
  templateUrl: 'app/content-list.html',
  providers: [ContentStore],
  styleUrls: ['app/content-list.css'],
  // directives: [Content]
})

export class ContentList {

	constructor(private store: ContentStore, private contentService: ContentService) {
	}

  addContentHandler(query) {
    this.store.contents.map((content) => {
        this.store.dispatch(skipAction(content.id));
    });

    this.contentService.getContent(query).subscribe(resp => {
      console.log(resp)

      let items = resp.items.slice(0,3);

      for (let item of items) {
        var title = item.title;
        var link = item.link;
        var summary = item.summary;
        this.store.dispatch(addContentAction(link, title, item.id, summary));
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
