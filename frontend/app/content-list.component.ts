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
	contentID: number;

	constructor(private store: ContentStore, private contentService: ContentService) {
		this.contentID = 0;
	}

  addContent(url) {
    this.contentService.getContent(url).subscribe(resp => {
      console.log(resp)
      let items = resp.items;

      for (let item of items) {
        var title = item.title[0];
        var link = item.link[0];
        var summary = item.summary[0];
        this.store.dispatch(addContent(url, title, this.contentID++, summary));
      }

    },err => {
      // Log errors if any
      console.log(err);
  })
  }
}
