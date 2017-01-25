import { Component } from '@angular/core';
import { ContentList } from './content-list.component'
import { ContentService } from './content-service';

@Component({
  selector: 'my-app',
  templateUrl: 'app/app.html',
  // styleUrls: ['app/app.css'],
})
export class AppComponent {
    constructor(private contentService: ContentService) {
    }
}
