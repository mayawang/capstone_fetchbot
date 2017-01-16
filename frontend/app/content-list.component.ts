import { Component } from '@angular/core';
import { ContentStore } from './content-store';
import { Content } from './content.component';
import { addContent } from './actions';
import { ContentService } from './content-service';

@Component({
  selector: 'content-list',
  templateUrl: 'app/content-list.html',
  providers: [ContentStore, ContentService],
  styleUrls: ['app/content-list.css'],
  // directives: [Content]
})

export class ContentList {

	constructor(private store: ContentStore, private contentService: ContentService) {
	}

  addContent(query) {
    this.contentService.getContent(query).subscribe(resp => {
      console.log(resp)
      let items = resp.items;

      for (let item of items) {
        var title = item.title;
        var link = item.link;
        var summary = item.summary;
        this.store.dispatch(addContent(query, title, item.id, summary));
      }

    },err => {
      // Log errors if any
      console.log(err);
    })
  }
}
