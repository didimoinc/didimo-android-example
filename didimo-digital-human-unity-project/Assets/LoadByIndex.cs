using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
public class LoadByIndex : MonoBehaviour
{
   public void LoadByIntID(int id)
    {
        SceneManager.LoadScene(id);
    }
}
