package com.work.controller;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.ModelAndView;

import com.google.gson.Gson;
import com.work.dao.StudentMapper;
import com.work.entity.ComboTable;
import com.work.entity.Department;
import com.work.entity.Student;
import com.work.entity.StudentSearch;
import com.work.util.MsgPropSource;

@Controller @RequestMapping("/student")
public class StudentController {
	
	/*@Autowired
	StudentDAO studentDAO;*/
	@Autowired
	StudentMapper studentMapper;
	
	private static final String LISTSTUDENTS = "ListStudents";
	private static final String ADDSTUDENT = "AddStudent";
	private static final String LOGINPAGE = "Login";
	
	@RequestMapping("/list")
	public String studentsList(Model model){
		model.addAttribute("student", new Student());
		model = commonFunForListOfStudents(model);		
		return LISTSTUDENTS;
	}
	
	@RequestMapping("/displayAddForm")
	public String displayAddForm(Model model){
		model.addAttribute("student", new Student());
		model.addAttribute("stateList", studentMapper.getListOfStates());
		model.addAttribute("deptList", studentMapper.getDepartmentList());
		model.addAttribute("skills", studentMapper.getSkillsList());
		return ADDSTUDENT;
	}
	
	@RequestMapping(value = "/saveProcess")
	public String saveProcess(Model model, @ModelAttribute("student") Student student){
		Object[] obj = {"Username:",student.getUserName()};
		
		if(student.getId()==null){
			if(studentMapper.isUsernameExists(student.getUserName())){
				model.addAttribute("deleteMessage", MsgPropSource.getMessage("user_exists", obj));
				model = commonFunForCityBasedOnState(model, student);
				return ADDSTUDENT;
			}
			if(student.getPassword() != null){
				student.setPassword(student.getPassword());
			}else{
				student.setPassword(student.getReset());
			}
			student.setHobbies(student.getHobbies().substring(1, student.getHobbies().length()));
			student.setGender(student.getGender().substring(1, student.getGender().length()));
			student.setCity(student.getCity().substring(1, student.getCity().length()));
			studentMapper.saveStudentObject(student);
			model.addAttribute("successMessage", MsgPropSource.getMessage("save_student", obj));
		}else{
			if(student.getPassword() != null){
				student.setPassword(student.getPassword());
			}else{
				student.setPassword(student.getReset());
			}
			student.setHobbies(student.getHobbies().substring(1, student.getHobbies().length()));
			student.setGender(student.getGender().substring(1, student.getGender().length()));
			student.setCity(student.getCity().substring(1, student.getCity().length()));
			studentMapper.updateStudentObject(student);
			model.addAttribute("updateMessage", MsgPropSource.getMessage("update_student", obj));
		}
		model = commonFunForListOfStudents(model);
		return LISTSTUDENTS;
	}

	@RequestMapping("/displayUpdateForm")
	public String displayUpdateForm(@RequestParam("studentId") int theId, Model model){
		Student studentObj = studentMapper.getStudent(theId);
		model.addAttribute("student", studentObj);
		model = commonFunForCityBasedOnState(model, studentObj);
		model.addAttribute("deptList", studentMapper.getDepartmentList());
		model.addAttribute("editBoolean", true);
		model.addAttribute("skills", studentMapper.getSkillsList());
		return ADDSTUDENT;
	}
	
	@RequestMapping("/displayDeleteForm")
	public String deleteStudent(@RequestParam("studentId") int theId, Model model){
		Student studentObj = studentMapper.getStudent(theId);
		Object[] obj = {"User Name: ",studentObj.getUserName()};
		model.addAttribute("deleteMessage", MsgPropSource.getMessage("delete_student", obj));
		studentMapper.deleteStudentObj(theId);
		model = commonFunForListOfStudents(model);
		model.addAttribute("student", new Student());
		return LISTSTUDENTS;
	}
	
	@RequestMapping("/getCity")
	public void getCity(String tableField, HttpServletResponse response) throws IOException, NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, ClassNotFoundException, InstantiationException{
		List<ComboTable> comboValues = studentMapper.getListOfCity(tableField);
		HashMap<String, String> setComboValues = new HashMap<String, String>();
		for(int i = 0; i < comboValues.size(); i++){
			setComboValues.put(comboValues.get(i).getValue(), comboValues.get(i).getText());
		}
		response.getWriter().write(new Gson().toJson(setComboValues));
	}
	
	@RequestMapping("/searchProcess")
	public String searchProcess(@ModelAttribute("student") Student studentObj, Model model, HttpServletRequest request){
		List<StudentSearch> allStudents = studentMapper.getListOfStudents(studentObj);
		if(studentObj.getSearch().equals("")){
			model = commonFunForListOfStudents(model);
			return LISTSTUDENTS;
		}
		if(allStudents.size() == 0){
			model.addAttribute("updateMessage", "No records found");
			return LISTSTUDENTS;
		}
		model.addAttribute("theStudents", allStudents);
		if(studentObj.getSecSearch() != null){
			List<ComboTable> comboValues = studentMapper.getListOfCity(studentObj.getSearch());
			HashMap<String, String> setComboValues = new HashMap<String, String>();
			for(int i = 0; i < comboValues.size(); i++){
				setComboValues.put(comboValues.get(i).getValue(), comboValues.get(i).getText());
			}
			model.addAttribute("changed", true);
			model.addAttribute("setComboValues", setComboValues);
		}
		return LISTSTUDENTS;
	}
	
	@RequestMapping("/displayLoginForm")
	public String displayLoginPage(Model model){
		model.addAttribute("student", new Student());
		return LOGINPAGE;
	}
	
	@RequestMapping("/loginProcess")
	public String loginProcess(@ModelAttribute("student") Student studentObj, Model model){
		List<Student> studentsList = studentMapper.getLoginDetails(studentObj);
		if(studentsList.size() > 0 || (studentObj.getUserName().equals("admin") && studentObj.getPassword().equals("admin"))){
			model = commonFunForListOfStudents(model);
			return LISTSTUDENTS;
		}
		model.addAttribute("wrong", "username and password is wrong!");
		return LOGINPAGE;
	}
	
	@RequestMapping("/logout")
	public String logout(Model model){
		model.addAttribute("student", new Student());
		model.addAttribute("wrong", "Successfully logged out from the application");
		return LOGINPAGE;
	}
	
	@RequestMapping("/checkUsername")
	public void checkUsername(String username, HttpServletResponse response) throws IOException, NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, ClassNotFoundException, InstantiationException{
		boolean flag = studentMapper.isUsernameExists(username);
		response.getWriter().write(new Gson().toJson(flag));
	}
	
	@RequestMapping("/getSearchDropDown")
	public void getSearchDropDownList(String tableField, HttpServletResponse response) throws IOException, NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, ClassNotFoundException, InstantiationException{
		List<ComboTable> comboValues = studentMapper.getListOfCity(tableField);
		HashMap<String, String> setComboValues = new HashMap<String, String>();
		for(int i = 0; i < comboValues.size(); i++){
			setComboValues.put(comboValues.get(i).getValue(), comboValues.get(i).getText());
		}
		response.getWriter().write(new Gson().toJson(setComboValues));
	}
	
	@RequestMapping("/findById")
	public void findById(@RequestParam("studentId") int theId, HttpServletResponse response)throws IOException, NoSuchMethodException, SecurityException, IllegalAccessException, IllegalArgumentException, InvocationTargetException, ClassNotFoundException, InstantiationException{
		Student studentObj = studentMapper.getStudent(theId);
		response.getWriter().write(new Gson().toJson(studentObj));
	}
	
	public Model commonFunForCityBasedOnState(Model model, Student student){
		model.addAttribute("stateList", studentMapper.getListOfStates());
		if(student.getCity() != null){
			List<ComboTable> comboValues = studentMapper.getListOfCity(student.getState());
			HashMap<String, String> setComboValues = new HashMap<String, String>();
			for(int i = 0; i < comboValues.size(); i++){
				setComboValues.put(comboValues.get(i).getValue(), comboValues.get(i).getText());
			}
			model.addAttribute("changed", true);
			model.addAttribute("setComboValues", setComboValues);
		}
		return model;
	}
	
	public Model commonFunForListOfStudents(Model model){
		List<StudentSearch> theStudents = studentMapper.getStudents();
		model.addAttribute("theStudents", theStudents);
		return model;
	}
}