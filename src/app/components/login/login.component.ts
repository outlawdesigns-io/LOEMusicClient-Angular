import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { ApiService } from '../../services/api.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  constructor(private router:Router, private api:ApiService) { }

  ngOnInit() {
    this.api.ensureInitialized().then(()=>{
      this.api.verifyToken().then(()=>{
        this.router.navigateByUrl('/recent');
      });
    });
  }

}
