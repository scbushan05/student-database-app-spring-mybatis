package com.work.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.work.entity.ComboTable;
import com.work.entity.Department;
import com.work.entity.Student;
import com.work.entity.StudentSearch;
import com.work.util.MyBatisUtil;

@Repository
public class StudentMapper {
	
	public void saveStudentObject(Student student){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();	
		session.insert("insertStudent", student);
		session.commit();
		session.close();
	}
	
	public void updateStudentObject(Student student){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();	
		session.update("updateStudent", student);
		session.commit();
		session.close();
	}
	
	public List<ComboTable> getListOfStates(){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<ComboTable> statesList = session.selectList("selectStates");
		session.commit();
		session.close();
		return statesList;
	}
	
	public Student getStudent(int theId){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		Student student = (Student) session.selectOne("findById", theId);
		session.commit();
		session.close();
		return student;
	}
	
	public List<StudentSearch> getStudents(){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<StudentSearch> listOfAllStudents = session.selectList("selectAllStudents");
		session.commit();
		session.close();
		return listOfAllStudents;
	}
	
	public void deleteStudentObj(int theId){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		session.delete("deleteStudent", theId);
		session.commit();
		session.close();
	}
	
	public List<ComboTable> getListOfCity(String tableField){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<ComboTable> listOfCities = session.selectList("selectCities", tableField);
		session.commit();
		session.close();
		return listOfCities;
	}
	
	public List<StudentSearch> getListOfStudents(Student studentObj){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<StudentSearch> listOfSearchedStudents = session.selectList("searchStudents", studentObj);
		session.commit();
		session.close();
		return listOfSearchedStudents;
	}
	
	public List<Student> getLoginDetails(Student studentObj){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<Student> loginDetails = session.selectList("userLoginDetails", studentObj);
		session.commit();
		session.close();
		return loginDetails;
	}
	
	public List<Department> getDepartmentList(){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<Department> departmentList = session.selectList("departmentList");
		session.commit();
		session.close();
		return departmentList;
	}
	
	public List<ComboTable> getSkillsList(){
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<ComboTable> skillsList = session.selectList("skillsList");
		session.commit();
		session.close();
		return skillsList;
	}
	
	public boolean isUsernameExists(String userName){
		boolean flag = false;
		SqlSession session = MyBatisUtil.getSqlSessionFactory().openSession();
		List<Student> student = session.selectList("isUsernameExists", userName);
		if(student.size() > 0){
			flag = true;
		}else{
			flag = false;
		}
		session.commit();
		session.close();
		return flag;
	}
}
