import { Observable } from 'RxJS/Rx';
import { Injectable } from '@angular/core';
import { Http, Response } from '@angular/http';
import { Content } from './content.component';

import 'rxjs/add/operator/map'

@Injectable()
export class ContentService {
  private baseUrl: string = 'http://localhost:9080/crawl.json?spider_name=pagespider&url='

  constructor(private http: Http) {
    this.http = http;
  }

  getContent(url): Observable<any> {
    return this.http.get( this.baseUrl + encodeURIComponent(url))
        .map((response) => response.json());
  }
}
