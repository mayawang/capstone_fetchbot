import { Component } from '@angular/core';
import { ContentStore } from './content-store';
import { Content } from './content.component';
import { addContent } from './actions';

@Component({
  selector: 'content-list',
  templateUrl: 'app/content-list.html',
  providers: [ContentStore],
  styleUrls: ['app/content-list.css'],
  // directives: [Content]
})

export class ContentList {
	contentID: number;

	constructor(private store: ContentStore) {
		this.contentID = 0;
	}

  addContent(content) {
    this.store.dispatch(addContent(content, this.contentID++, "desc", "link"));
  }
}
