package com.klu.project.HFMP.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.klu.project.HFMP.model.Artisan;
import com.klu.project.HFMP.service.ArtisanService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class ArtisanController {


  @Autowired
  private ArtisanService artisanservice;
  
  @PostMapping("checkartisanlogin")
  public ModelAndView checkartisanlogin(HttpServletRequest request)
  {
    ModelAndView mv = new ModelAndView();
    String email = request.getParameter("amail");
    String pwd = request.getParameter("apwd");
    
    
     Artisan a = artisanservice.checkartisanlogin(email, pwd);
    if(a!=null)
    {
      
      mv.setViewName("artisans");
    }
    else
    {
//      return "Fail";
      mv.setViewName("artisanlogin");
      mv.addObject("message","Login Failed");
    }
    return mv;
  }
  
  @GetMapping("artisansignup")
  public ModelAndView artisansignup()
  {
    ModelAndView mv = new ModelAndView();
    mv.setViewName("artisansignup");
    return mv;
  }
  
  @GetMapping("artisandashboard")
  public ModelAndView artisandashboard()
  {
    ModelAndView mv = new ModelAndView();
    mv.setViewName("artisans");
    return mv;
  }
  
  @GetMapping("artisanlogin")
  public ModelAndView artisanlogin()
  {
    ModelAndView mv = new ModelAndView();
    mv.setViewName("artisanlogin");
    return mv;
  }
  
  
  @PostMapping("insertartisan1")
     public ModelAndView insertartisan1(HttpServletRequest request)
     {
        String aname = request.getParameter("aname");
   
      String amail = request.getParameter("amail");
      String apwd = request.getParameter("apwd");
      String anumber = request.getParameter("anumber");
      
        Artisan a =new Artisan();
        
       a.setAname(aname);
       a.setAmail(amail);
       a.setApwd(apwd);
       a.setAnumber(anumber);
       
       artisanservice.ArtisanRegistration(a);
        
        ModelAndView mv = new ModelAndView("artisanlogin");
      
      
        return mv;

     }
  
  @GetMapping("/addartisan")
  public ModelAndView addartisan()
  {
    ModelAndView mv = new ModelAndView();
    mv.setViewName("addartisan");
    return mv;
  }
  
  
  // View Profile
    @GetMapping("/profile/{id}")
    public ModelAndView viewProfile(@PathVariable Integer id) {
        ModelAndView mv = new ModelAndView("artisanProfile");
        Artisan artisan = artisanservice.findById(id);
        mv.addObject("artisan", artisan);
        return mv;
    }

    
  
}